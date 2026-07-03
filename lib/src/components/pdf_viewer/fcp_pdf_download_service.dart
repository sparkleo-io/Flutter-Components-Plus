import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Result of checking or requesting storage access for PDF downloads.
class FCPPdfStoragePermissionResult {
  const FCPPdfStoragePermissionResult({
    required this.isGranted,
    required this.permissionRequested,
    required this.message,
    this.canOpenSettings = false,
  });

  final bool isGranted;
  final bool permissionRequested;
  final String message;
  final bool canOpenSettings;

  factory FCPPdfStoragePermissionResult.granted() {
    return const FCPPdfStoragePermissionResult(
      isGranted: true,
      permissionRequested: false,
      message: 'Storage access granted',
    );
  }
}

/// Result of a PDF download operation.
class FCPPdfDownloadResult {
  const FCPPdfDownloadResult({
    required this.filePath,
    required this.fileName,
    required this.savedToPublicDownloads,
  });

  final String filePath;
  final String fileName;
  final bool savedToPublicDownloads;
}

/// Downloads PDF files to a user-visible location when possible.
class FCPPdfDownloadService {
  FCPPdfDownloadService._();

  static final FCPPdfDownloadService instance = FCPPdfDownloadService._();

  static const String _androidDownloadFolder = 'FCP';
  bool _mediaStoreInitialized = false;

  /// Initializes Android MediaStore support. Safe to call multiple times.
  ///
  /// Call this from `main()` before `runApp`. On Android release builds with
  /// R8 enabled, apps must also add Gson ProGuard rules to
  /// `android/app/proguard-rules.pro` (see the package example app).
  Future<void> initialize() async {
    if (!Platform.isAndroid || _mediaStoreInitialized) {
      return;
    }

    await MediaStore.ensureInitialized();
    MediaStore.appFolder = _androidDownloadFolder;
    _mediaStoreInitialized = true;
  }

  /// Checks whether storage access is available and requests it when required.
  ///
  /// On Android 10+ public Downloads are saved through MediaStore and do not
  /// need legacy storage permission. Android 9 and below still require it.
  Future<FCPPdfStoragePermissionResult>
      ensureStoragePermissionForDownload() async {
    if (!Platform.isAndroid) {
      return FCPPdfStoragePermissionResult.granted();
    }

    final sdkInt = await _androidSdkInt();
    if (sdkInt >= 29) {
      await initialize();
      return FCPPdfStoragePermissionResult.granted();
    }

    final currentStatus = await Permission.storage.status;
    if (currentStatus.isGranted) {
      return FCPPdfStoragePermissionResult.granted();
    }

    if (currentStatus.isPermanentlyDenied) {
      return const FCPPdfStoragePermissionResult(
        isGranted: false,
        permissionRequested: false,
        canOpenSettings: true,
        message:
            'Storage permission is permanently denied. Open app settings and allow storage access to download PDFs.',
      );
    }

    if (currentStatus.isRestricted) {
      return const FCPPdfStoragePermissionResult(
        isGranted: false,
        permissionRequested: false,
        message: 'Storage access is restricted on this device.',
      );
    }

    final requestedStatus = await Permission.storage.request();
    if (requestedStatus.isGranted) {
      return FCPPdfStoragePermissionResult.granted();
    }

    if (requestedStatus.isPermanentlyDenied) {
      return const FCPPdfStoragePermissionResult(
        isGranted: false,
        permissionRequested: true,
        canOpenSettings: true,
        message:
            'Storage permission was denied. Open app settings and allow storage access to download PDFs.',
      );
    }

    return const FCPPdfStoragePermissionResult(
      isGranted: false,
      permissionRequested: true,
      message:
          'Storage permission was not granted. Allow storage access to download PDFs to your device.',
    );
  }

  /// Opens the app settings page so the user can grant storage permission.
  Future<bool> openStorageSettings() {
    return openAppSettings();
  }

  /// Downloads a PDF from [url] and saves it to the device.
  Future<FCPPdfDownloadResult> downloadFromUrl(
    String url, {
    String? fileName,
    Map<String, String>? headers,
    bool saveToPublicDownloads = true,
  }) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw FCPPdfDownloadException(
        'Download failed with HTTP ${response.statusCode}',
      );
    }

    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      throw const FCPPdfDownloadException('Downloaded file is empty');
    }

    if (!_looksLikePdf(bytes)) {
      throw const FCPPdfDownloadException(
        'URL did not return a valid PDF file',
      );
    }

    final resolvedName = _resolveFileName(url, fileName);
    return saveBytes(
      bytes,
      fileName: resolvedName,
      saveToPublicDownloads: saveToPublicDownloads,
    );
  }

  /// Saves already-loaded PDF [bytes] to the device.
  Future<FCPPdfDownloadResult> saveBytes(
    List<int> bytes, {
    required String fileName,
    bool saveToPublicDownloads = true,
  }) async {
    if (bytes.isEmpty) {
      throw const FCPPdfDownloadException('Cannot save an empty PDF');
    }

    if (!_looksLikePdf(bytes)) {
      throw const FCPPdfDownloadException('Data is not a valid PDF file');
    }

    if (saveToPublicDownloads) {
      final permission = await ensureStoragePermissionForDownload();
      if (!permission.isGranted) {
        throw FCPPdfDownloadException(permission.message);
      }
    }

    final resolvedName = _ensurePdfExtension(fileName);
    final savedFile = await _saveBytes(
      bytes,
      resolvedName,
      saveToPublicDownloads: saveToPublicDownloads,
    );

    return FCPPdfDownloadResult(
      filePath: savedFile.path,
      fileName: resolvedName,
      savedToPublicDownloads: saveToPublicDownloads,
    );
  }

  Future<File> _saveBytes(
    List<int> bytes,
    String fileName, {
    required bool saveToPublicDownloads,
  }) async {
    if (Platform.isAndroid && saveToPublicDownloads) {
      return _saveToAndroidDownloads(bytes, fileName);
    }

    final directory = saveToPublicDownloads
        ? await _resolvePublicDownloadDirectory()
        : await getApplicationDocumentsDirectory();

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final file = File(p.join(directory.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File> _saveToAndroidDownloads(List<int> bytes, String fileName) async {
    await initialize();

    final tempDir = await getTemporaryDirectory();
    final safeName = fileName.replaceAll(RegExp(r'[^\w.\-]'), '_');
    final tempFile = File(p.join(tempDir.path, safeName));
    await tempFile.writeAsBytes(bytes, flush: true);

    SaveInfo? saveInfo;
    try {
      saveInfo = await MediaStore().saveFile(
        tempFilePath: tempFile.path,
        dirType: DirType.download,
        dirName: DirName.download,
      );
    } on PlatformException catch (error) {
      throw FCPPdfDownloadException(
        'Failed to save PDF to Downloads: ${error.message ?? error.code}',
      );
    }

    if (saveInfo == null || !saveInfo.isSuccessful) {
      throw const FCPPdfDownloadException(
        'Failed to save PDF to the Downloads folder. ',
      );
    }

    return File(saveInfo.uri.toString());
  }

  Future<Directory> _resolvePublicDownloadDirectory() async {
    if (Platform.isIOS) {
      final downloads = await getDownloadsDirectory();
      if (downloads != null) {
        return downloads;
      }
    }

    return getApplicationDocumentsDirectory();
  }

  Future<int> _androidSdkInt() async {
    if (!Platform.isAndroid) {
      return 0;
    }

    final info = await DeviceInfoPlugin().androidInfo;
    return info.version.sdkInt;
  }

  bool _looksLikePdf(List<int> bytes) {
    if (bytes.length < 4) {
      return false;
    }

    return bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46;
  }

  String _resolveFileName(String url, String? fileName) {
    if (fileName != null && fileName.trim().isNotEmpty) {
      return _ensurePdfExtension(fileName.trim());
    }

    final uri = Uri.parse(url);
    final lastSegment =
        uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'document.pdf';
    return _ensurePdfExtension(lastSegment);
  }

  String _ensurePdfExtension(String name) {
    return name.toLowerCase().endsWith('.pdf') ? name : '$name.pdf';
  }
}

/// Thrown when a PDF download or save operation fails.
class FCPPdfDownloadException implements Exception {
  const FCPPdfDownloadException(this.message);

  final String message;

  @override
  String toString() => message;
}
