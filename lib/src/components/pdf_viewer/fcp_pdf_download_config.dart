import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Enum defining the different types of PDF sources
enum FCPPdfType {
  /// PDF from a file on the device (absolute path from a file picker or similar).
  local,

  /// PDF from network URL
  network,

  /// PDF from app assets
  assets,
}

/// Where the built-in download button is placed over the PDF viewer.
enum FCPPdfDownloadButtonAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  topCenter,
  bottomCenter,
}

/// Whether the package or the host app performs the download/save flow.
enum FCPPdfDownloadMode {
  /// Saves using [FCPPdfDownloadService] (permissions, paths, MediaStore).
  internal,

  /// Delegates to [FCPPdfViewer.onDownload]; the app owns storage/sharing.
  external,
}

/// PDF metadata passed to [FCPPdfDownloadCallback] in external mode.
class FCPPdfDownloadRequest {
  const FCPPdfDownloadRequest({
    required this.pdfType,
    required this.suggestedFileName,
    this.pdfUrl,
    this.pdfPath,
    this.pdfBytes,
    this.networkHeaders,
  });

  final FCPPdfType pdfType;
  final String? pdfUrl;
  final String? pdfPath;
  final Uint8List? pdfBytes;
  final String suggestedFileName;
  final Map<String, String>? networkHeaders;
}

/// Called when [FCPPdfDownloadMode.external] is used.
typedef FCPPdfDownloadCallback = Future<void> Function(
    FCPPdfDownloadRequest request);

/// Optional styling for the built-in download button.
class FCPPdfDownloadButtonStyle {
  const FCPPdfDownloadButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.icon = Icons.download,
    this.elevation,
    this.padding = const EdgeInsets.all(16),
    this.heroTag,
    this.tooltip,
    this.loadingIndicatorColor,
    this.loadingIndicatorSize = 18,
    this.loadingStrokeWidth = 2,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData icon;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final Object? heroTag;
  final String? tooltip;
  final Color? loadingIndicatorColor;
  final double loadingIndicatorSize;
  final double loadingStrokeWidth;
}

/// State passed to [FCPPdfDownloadButtonBuilder].
class FCPPdfDownloadButtonState {
  const FCPPdfDownloadButtonState({
    required this.isDownloading,
    required this.onPressed,
  });

  final bool isDownloading;
  final VoidCallback onPressed;
}

/// Fully custom download button; alignment still comes from
/// [FCPPdfViewer.downloadButtonAlignment].
typedef FCPPdfDownloadButtonBuilder = Widget Function(
  BuildContext context,
  FCPPdfDownloadButtonState state,
);
