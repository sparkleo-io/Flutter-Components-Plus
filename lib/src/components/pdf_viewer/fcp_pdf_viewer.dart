import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/theme/color_scheme.dart';
import 'fcp_pdf_download_config.dart';
import 'fcp_pdf_download_service.dart';

/// Custom PDF Viewer for Flutter Components Plus with enhanced features
class FCPPdfViewer extends StatefulWidget {
  /// URL for network PDF
  final String? pdfUrl;

  /// Local file path or asset path for PDF
  final String? pdfPath;

  /// Type of PDF source
  final FCPPdfType pdfType;

  /// Global key for the PDF viewer
  final GlobalKey? pdfViewerKey;

  /// Whether to show zoom controls
  final bool showZoomControls;

  /// Whether to show scroll head
  final bool showScrollHead;

  /// Whether to enable text selection
  final bool enableTextSelection;

  /// Whether to enable document link annotation
  final bool enableDocumentLinkAnnotation;

  /// Whether to enable hyperlink navigation
  final bool enableHyperlinkNavigation;

  /// Initial zoom level (1.0 = 100%)
  final double initialZoomLevel;

  /// Maximum zoom level
  final double maxZoomLevel;

  /// Minimum zoom level
  final double minZoomLevel;

  /// Background color of the PDF viewer
  final Color? backgroundColor;

  /// Loading widget to show while PDF is loading
  final Widget? loadingWidget;

  /// Error widget to show when PDF fails to load
  final Widget? errorWidget;

  /// Callback when PDF starts loading
  final VoidCallback? onDocumentLoaded;

  /// Callback when PDF loading fails
  final Function(String)? onDocumentLoadFailed;

  /// Callback when page changes
  final Function(int)? onPageChanged;

  /// Callback when zoom level changes
  final Function(double)? onZoomLevelChanged;

  /// Custom PDF viewer controller
  final PdfViewerController? controller;

  /// Whether to show page navigation controls
  final bool showPageNavigationControls;

  /// Whether to show search functionality
  final bool showSearch;

  /// Search text to highlight
  final String? searchText;

  /// Whether to show the download button
  final bool showDownloadButton;

  /// Placement of the built-in download button
  final FCPPdfDownloadButtonAlignment downloadButtonAlignment;

  /// Visual styling for the built-in download button
  final FCPPdfDownloadButtonStyle? downloadButtonStyle;

  /// Custom download button widget (overrides default FAB styling)
  final FCPPdfDownloadButtonBuilder? downloadButtonBuilder;

  /// Who handles saving the PDF ([internal] = package, [external] = app)
  final FCPPdfDownloadMode downloadMode;

  /// File name used when downloading a PDF
  final String? downloadFileName;

  /// Save downloads to the public Downloads folder when supported
  final bool saveToPublicDownloads;

  /// Optional HTTP headers for network PDF requests
  final Map<String, String>? networkHeaders;

  /// Callback when a download starts
  final VoidCallback? onDownloadStarted;

  /// App-owned download handler when [downloadMode] is [FCPPdfDownloadMode.external]
  final FCPPdfDownloadCallback? onDownload;

  /// Callback when a download completes
  final Function(FCPPdfDownloadResult result)? onDownloadCompleted;

  /// Callback when a download fails
  final Function(String error)? onDownloadFailed;

  /// Custom PDF Viewer for Flutter Components Plus
  const FCPPdfViewer({
    super.key,
    this.pdfUrl,
    this.pdfPath,
    required this.pdfType,
    this.pdfViewerKey,
    this.showZoomControls = true,
    this.showScrollHead = true,
    this.enableTextSelection = true,
    this.enableDocumentLinkAnnotation = true,
    this.enableHyperlinkNavigation = true,
    this.initialZoomLevel = 1.0,
    this.maxZoomLevel = 3.0,
    this.minZoomLevel = 0.25,
    this.backgroundColor,
    this.loadingWidget,
    this.errorWidget,
    this.onDocumentLoaded,
    this.onDocumentLoadFailed,
    this.onPageChanged,
    this.onZoomLevelChanged,
    this.controller,
    this.showPageNavigationControls = true,
    this.showSearch = true,
    this.searchText,
    this.showDownloadButton = false,
    this.downloadButtonAlignment = FCPPdfDownloadButtonAlignment.topLeft,
    this.downloadButtonStyle,
    this.downloadButtonBuilder,
    this.downloadMode = FCPPdfDownloadMode.internal,
    this.downloadFileName,
    this.saveToPublicDownloads = true,
    this.networkHeaders,
    this.onDownloadStarted,
    this.onDownload,
    this.onDownloadCompleted,
    this.onDownloadFailed,
  });

  @override
  State<FCPPdfViewer> createState() => _FCPPdfViewerState();
}

class _FCPPdfViewerState extends State<FCPPdfViewer> {
  late PdfViewerController _controller;
  bool _isLoading = true;
  bool _isDownloading = false;
  bool _hasError = false;
  String _errorMessage = '';
  Uint8List? _networkPdfBytes;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PdfViewerController();
    if (widget.pdfType == FCPPdfType.network) {
      _loadNetworkPdf();
    } else {
      _isLoading = false;
    }
  }

  @override
  void didUpdateWidget(covariant FCPPdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pdfType == FCPPdfType.network &&
        widget.pdfUrl != oldWidget.pdfUrl) {
      _loadNetworkPdf();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadNetworkPdf() async {
    final url = widget.pdfUrl;
    if (url == null || url.isEmpty) {
      _setLoadError('PDF URL is required for network PDFs');
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
      _networkPdfBytes = null;
    });

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: widget.networkHeaders,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _setLoadError('Failed to load PDF (HTTP ${response.statusCode})');
        return;
      }

      final bytes = response.bodyBytes;
      if (bytes.isEmpty) {
        _setLoadError('Downloaded PDF is empty');
        return;
      }

      if (!_looksLikePdf(bytes)) {
        _setLoadError(
          'The URL did not return a PDF file. Use a direct .pdf link.',
        );
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _networkPdfBytes = Uint8List.fromList(bytes);
        _isLoading = false;
      });
      widget.onDocumentLoaded?.call();
    } catch (error) {
      _setLoadError('Failed to load PDF: $error');
    }
  }

  void _setLoadError(String message) {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _hasError = true;
      _errorMessage = message;
    });
    widget.onDocumentLoadFailed?.call(message);
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

  Future<void> _handleDownload() async {
    if (_isDownloading) {
      return;
    }

    setState(() => _isDownloading = true);
    widget.onDownloadStarted?.call();

    try {
      if (widget.downloadMode == FCPPdfDownloadMode.external) {
        final callback = widget.onDownload;
        if (callback == null) {
          throw const FCPPdfDownloadException(
            'onDownload is required when downloadMode is external',
          );
        }

        await callback(_buildDownloadRequest());
        return;
      }

      await _handleInternalDownload();
    } catch (error) {
      widget.onDownloadFailed?.call(error.toString());
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  FCPPdfDownloadRequest _buildDownloadRequest() {
    final suggestedName = widget.downloadFileName ?? _defaultDownloadFileName();

    return FCPPdfDownloadRequest(
      pdfType: widget.pdfType,
      pdfUrl: widget.pdfUrl,
      pdfPath: widget.pdfPath,
      pdfBytes: widget.pdfType == FCPPdfType.network ? _networkPdfBytes : null,
      suggestedFileName: suggestedName,
      networkHeaders: widget.networkHeaders,
    );
  }

  String _defaultDownloadFileName() {
    switch (widget.pdfType) {
      case FCPPdfType.network:
        return 'document.pdf';
      case FCPPdfType.local:
        final path = widget.pdfPath;
        if (path == null || path.isEmpty) {
          return 'document.pdf';
        }
        return File(path).uri.pathSegments.last;
      case FCPPdfType.assets:
        final path = widget.pdfPath;
        if (path == null || path.isEmpty) {
          return 'document.pdf';
        }
        return path.split('/').last;
    }
  }

  Future<void> _handleInternalDownload() async {
    if (widget.saveToPublicDownloads) {
      final permission = await FCPPdfDownloadService.instance
          .ensureStoragePermissionForDownload();
      if (!permission.isGranted) {
        throw FCPPdfDownloadException(permission.message);
      }
    }

    final FCPPdfDownloadResult result;

    switch (widget.pdfType) {
      case FCPPdfType.network:
        final url = widget.pdfUrl;
        if (url == null || url.isEmpty) {
          throw const FCPPdfDownloadException('PDF URL is missing');
        }

        if (_networkPdfBytes != null) {
          result = await FCPPdfDownloadService.instance.saveBytes(
            _networkPdfBytes!,
            fileName: widget.downloadFileName ?? 'document.pdf',
            saveToPublicDownloads: widget.saveToPublicDownloads,
          );
        } else {
          result = await FCPPdfDownloadService.instance.downloadFromUrl(
            url,
            fileName: widget.downloadFileName,
            headers: widget.networkHeaders,
            saveToPublicDownloads: widget.saveToPublicDownloads,
          );
        }
      case FCPPdfType.local:
        final path = widget.pdfPath;
        if (path == null || path.isEmpty) {
          throw const FCPPdfDownloadException('Local PDF path is missing');
        }

        final file = File(path);
        if (!file.existsSync()) {
          throw FCPPdfDownloadException('Local PDF not found: $path');
        }

        result = await FCPPdfDownloadService.instance.saveBytes(
          await file.readAsBytes(),
          fileName: widget.downloadFileName ?? file.uri.pathSegments.last,
          saveToPublicDownloads: widget.saveToPublicDownloads,
        );
      case FCPPdfType.assets:
        throw const FCPPdfDownloadException(
          'Asset PDFs must be copied to the app before downloading',
        );
    }

    widget.onDownloadCompleted?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    }

    if (widget.pdfType == FCPPdfType.network && _networkPdfBytes == null) {
      return Container(
        color: widget.backgroundColor ?? FCPColorScheme.neutral50,
        child: _buildLoadingWidget(),
      );
    }

    return Container(
      color: widget.backgroundColor ?? FCPColorScheme.neutral50,
      child: _buildPdfViewer(),
    );
  }

  Widget _buildPdfViewer() {
    switch (widget.pdfType) {
      case FCPPdfType.local:
        return _buildLocalPdfViewer();
      case FCPPdfType.network:
        return _buildNetworkPdfViewer();
      case FCPPdfType.assets:
        return _buildAssetPdfViewer();
    }
  }

  Widget _buildLocalPdfViewer() {
    final file = File(widget.pdfPath!);
    if (!file.existsSync()) {
      return _buildErrorWidget(
        message: 'PDF file not found: ${widget.pdfPath}',
      );
    }

    return Stack(
      children: [
        SfPdfViewer.file(
          file,
          key: widget.pdfViewerKey,
          controller: _controller,
          enableTextSelection: widget.enableTextSelection,
          enableDocumentLinkAnnotation: widget.enableDocumentLinkAnnotation,
          enableHyperlinkNavigation: widget.enableHyperlinkNavigation,
          initialZoomLevel: widget.initialZoomLevel,
          maxZoomLevel: widget.maxZoomLevel,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            setState(() => _isLoading = false);
            widget.onDocumentLoaded?.call();
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            _setLoadError(details.error);
          },
          onPageChanged: (PdfPageChangedDetails details) {
            widget.onPageChanged?.call(details.newPageNumber);
          },
          onZoomLevelChanged: (PdfZoomDetails details) {
            widget.onZoomLevelChanged?.call(details.newZoomLevel);
          },
        ),
        _buildPdfViewerChild(),
      ],
    );
  }

  Widget _buildNetworkPdfViewer() {
    return Stack(
      children: [
        SfPdfViewer.memory(
          _networkPdfBytes!,
          key: widget.pdfViewerKey,
          controller: _controller,
          enableTextSelection: widget.enableTextSelection,
          enableDocumentLinkAnnotation: widget.enableDocumentLinkAnnotation,
          enableHyperlinkNavigation: widget.enableHyperlinkNavigation,
          initialZoomLevel: widget.initialZoomLevel,
          maxZoomLevel: widget.maxZoomLevel,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            setState(() => _isLoading = false);
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            _setLoadError(details.error);
          },
          onPageChanged: (PdfPageChangedDetails details) {
            widget.onPageChanged?.call(details.newPageNumber);
          },
          onZoomLevelChanged: (PdfZoomDetails details) {
            widget.onZoomLevelChanged?.call(details.newZoomLevel);
          },
        ),
        _buildPdfViewerChild(),
      ],
    );
  }

  Widget _buildAssetPdfViewer() {
    return Stack(
      children: [
        SfPdfViewer.asset(
          widget.pdfPath!,
          key: widget.pdfViewerKey,
          controller: _controller,
          enableTextSelection: widget.enableTextSelection,
          enableDocumentLinkAnnotation: widget.enableDocumentLinkAnnotation,
          enableHyperlinkNavigation: widget.enableHyperlinkNavigation,
          initialZoomLevel: widget.initialZoomLevel,
          maxZoomLevel: widget.maxZoomLevel,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            setState(() => _isLoading = false);
            widget.onDocumentLoaded?.call();
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            _setLoadError(details.error);
          },
          onPageChanged: (PdfPageChangedDetails details) {
            widget.onPageChanged?.call(details.newPageNumber);
          },
          onZoomLevelChanged: (PdfZoomDetails details) {
            widget.onZoomLevelChanged?.call(details.newZoomLevel);
          },
        ),
        _buildPdfViewerChild(),
      ],
    );
  }

  Widget _buildPdfViewerChild() {
    return Stack(
      children: [
        if (_isLoading) _buildLoadingWidget(),
        if (widget.showZoomControls) _buildZoomControls(),
        if (widget.showPageNavigationControls) _buildPageNavigationControls(),
        if (widget.showSearch && widget.searchText != null)
          _buildSearchControls(),
        if (widget.showDownloadButton) _buildDownloadControl(),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: Colors.white.withValues(alpha: 0.8),
      child: Center(
        child: widget.loadingWidget ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: FCPColorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  'Loading PDF...',
                  style: TextStyle(
                    color: FCPColorScheme.neutral700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildDownloadControl() {
    final style = widget.downloadButtonStyle ?? const FCPPdfDownloadButtonStyle();
    final state = FCPPdfDownloadButtonState(
      isDownloading: _isDownloading,
      onPressed: _isDownloading ? () {} : _handleDownload,
    );

    final button = widget.downloadButtonBuilder?.call(context, state) ??
        _buildDefaultDownloadButton(style, state);

    return _positionByAlignment(
      alignment: widget.downloadButtonAlignment,
      padding: style.padding,
      child: button,
    );
  }

  Widget _buildDefaultDownloadButton(
    FCPPdfDownloadButtonStyle style,
    FCPPdfDownloadButtonState state,
  ) {
    final fab = FloatingActionButton.small(
      heroTag: style.heroTag,
      tooltip: style.tooltip,
      elevation: style.elevation,
      onPressed: state.isDownloading ? null : state.onPressed,
      backgroundColor: style.backgroundColor ?? FCPColorScheme.primary,
      foregroundColor: style.foregroundColor ?? Colors.white,
      child: state.isDownloading
          ? SizedBox(
              width: style.loadingIndicatorSize,
              height: style.loadingIndicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: style.loadingStrokeWidth,
                color: style.loadingIndicatorColor ??
                    style.foregroundColor ??
                    Colors.white,
              ),
            )
          : Icon(style.icon),
    );

    return fab;
  }

  Widget _positionByAlignment({
    required FCPPdfDownloadButtonAlignment alignment,
    required EdgeInsetsGeometry padding,
    required Widget child,
  }) {
    final resolved = padding.resolve(Directionality.of(context));

    switch (alignment) {
      case FCPPdfDownloadButtonAlignment.topLeft:
        return Positioned(
          top: resolved.top,
          left: resolved.left,
          child: child,
        );
      case FCPPdfDownloadButtonAlignment.topRight:
        return Positioned(
          top: resolved.top,
          right: resolved.right,
          child: child,
        );
      case FCPPdfDownloadButtonAlignment.bottomLeft:
        return Positioned(
          bottom: resolved.bottom,
          left: resolved.left,
          child: child,
        );
      case FCPPdfDownloadButtonAlignment.bottomRight:
        return Positioned(
          bottom: resolved.bottom,
          right: resolved.right,
          child: child,
        );
      case FCPPdfDownloadButtonAlignment.topCenter:
        return Positioned(
          top: resolved.top,
          left: 0,
          right: 0,
          child: Align(alignment: Alignment.topCenter, child: child),
        );
      case FCPPdfDownloadButtonAlignment.bottomCenter:
        return Positioned(
          bottom: resolved.bottom,
          left: 0,
          right: 0,
          child: Align(alignment: Alignment.bottomCenter, child: child),
        );
    }
  }

  Widget _buildZoomControls() {
    return Positioned(
      right: 16,
      bottom: 16,
      child: Column(
        children: [
          FloatingActionButton.small(
            onPressed: () =>
                _controller.zoomLevel = _controller.zoomLevel + 0.25,
            backgroundColor: FCPColorScheme.primary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            onPressed: () =>
                _controller.zoomLevel = _controller.zoomLevel - 0.25,
            backgroundColor: FCPColorScheme.primary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNavigationControls() {
    return Positioned(
      left: 16,
      bottom: 16,
      child: Row(
        children: [
          FloatingActionButton.small(
            onPressed: () => _controller.previousPage(),
            backgroundColor: FCPColorScheme.primary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.small(
            onPressed: () => _controller.nextPage(),
            backgroundColor: FCPColorScheme.primary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchControls() {
    return Positioned(
      top: 16,
      right: 16,
      child: FloatingActionButton.small(
        onPressed: () => _controller.searchText(widget.searchText!),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildErrorWidget({String? message}) {
    return Container(
      color: Colors.white,
      child: Center(
        child: widget.errorWidget ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: FCPColorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load PDF',
                  style: TextStyle(
                    color: FCPColorScheme.error,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    message ?? _errorMessage,
                    style: TextStyle(
                      color: FCPColorScheme.neutral600,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (widget.pdfType == FCPPdfType.network) {
                      _loadNetworkPdf();
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                      _hasError = false;
                      _errorMessage = '';
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
      ),
    );
  }
}
