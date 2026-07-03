import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../core/theme/color_scheme.dart';

/// Enum defining the different types of PDF sources
enum FCPPdfType {
  /// PDF from local file system
  local,

  /// PDF from network URL
  network,

  /// PDF from app assets
  assets,
}

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
  });

  @override
  State<FCPPdfViewer> createState() => _FCPPdfViewerState();
}

class _FCPPdfViewerState extends State<FCPPdfViewer> {
  late PdfViewerController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PdfViewerController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
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
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = details.error;
            });
            widget.onDocumentLoadFailed?.call(details.error);
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
        SfPdfViewer.network(
          widget.pdfUrl!,
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
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = details.error;
            });
            widget.onDocumentLoadFailed?.call(details.error);
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
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = details.error;
            });
            widget.onDocumentLoadFailed?.call(details.error);
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
                Text(
                  message ?? _errorMessage,
                  style: TextStyle(
                    color: FCPColorScheme.neutral600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
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
