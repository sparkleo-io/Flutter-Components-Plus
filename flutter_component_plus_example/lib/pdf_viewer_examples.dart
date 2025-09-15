import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Example page demonstrating the FCPPdfViewer component
class PdfViewerExamples extends StatefulWidget {
  const PdfViewerExamples({super.key});

  @override
  State<PdfViewerExamples> createState() => _PdfViewerExamplesState();
}

class _PdfViewerExamplesState extends State<PdfViewerExamples> {
  late PdfViewerController _controller;
  int _currentPage = 1;
  double _currentZoom = 1.0;
  String _selectedPdfType = 'network';
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer Examples'),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            color: FCPColorScheme.neutral100,
            child: Column(
              children: [
                // PDF Type Selector
                Row(
                  children: [
                    const Text('PDF Type: '),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _selectedPdfType,
                      items: const [
                        DropdownMenuItem(
                          value: 'network',
                          child: Text('Network'),
                        ),
                        DropdownMenuItem(value: 'local', child: Text('Local')),
                        DropdownMenuItem(
                          value: 'assets',
                          child: Text('Assets'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedPdfType = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Page and Zoom Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Page: $_currentPage'),
                    Text('Zoom: ${(_currentZoom * 100).toStringAsFixed(0)}%'),
                  ],
                ),
                const SizedBox(height: 8),
                // Search
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search text...',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchText = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _searchText.isNotEmpty
                          ? () => _controller.searchText(_searchText)
                          : null,
                      child: const Text('Search'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // PDF Viewer
          Expanded(child: _buildPdfViewer()),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    switch (_selectedPdfType) {
      case 'network':
        return _buildNetworkPdfViewer();
      case 'local':
        return _buildLocalPdfViewer();
      case 'assets':
        return _buildAssetPdfViewer();
      default:
        return _buildNetworkPdfViewer();
    }
  }

  Widget _buildNetworkPdfViewer() {
    return FCPPdfViewer(
      pdfType: FCPPdfType.network,
      pdfUrl:
          'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
      controller: _controller,
      showZoomControls: true,
      showPageNavigationControls: true,
      showSearch: true,
      searchText: _searchText.isNotEmpty ? _searchText : null,
      backgroundColor: FCPColorScheme.neutral50,
      onDocumentLoaded: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF loaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onDocumentLoadFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF failed to load: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      onPageChanged: (pageNumber) {
        setState(() {
          _currentPage = pageNumber;
        });
      },
      onZoomLevelChanged: (zoomLevel) {
        setState(() {
          _currentZoom = zoomLevel;
        });
      },
    );
  }

  Widget _buildLocalPdfViewer() {
    return FCPPdfViewer(
      pdfType: FCPPdfType.local,
      pdfPath: '/path/to/local/document.pdf', // This would need a real path
      controller: _controller,
      showZoomControls: true,
      showPageNavigationControls: true,
      showSearch: false,
      enableTextSelection: true,
      backgroundColor: Colors.grey[100],
      loadingWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: FCPColorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Loading local PDF...',
              style: TextStyle(color: FCPColorScheme.neutral700, fontSize: 16),
            ),
          ],
        ),
      ),
      errorWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: FCPColorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Local PDF not found',
              style: TextStyle(
                color: FCPColorScheme.error,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please provide a valid local PDF path',
              style: TextStyle(color: FCPColorScheme.neutral600, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onDocumentLoaded: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Local PDF loaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onDocumentLoadFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Local PDF failed to load: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      onPageChanged: (pageNumber) {
        setState(() {
          _currentPage = pageNumber;
        });
      },
      onZoomLevelChanged: (zoomLevel) {
        setState(() {
          _currentZoom = zoomLevel;
        });
      },
    );
  }

  Widget _buildAssetPdfViewer() {
    return FCPPdfViewer(
      pdfType: FCPPdfType.assets,
      pdfPath: 'assets/documents/sample.pdf', // This would need a real asset
      controller: _controller,
      showZoomControls: false,
      showPageNavigationControls: true,
      showSearch: true,
      searchText: _searchText.isNotEmpty ? _searchText : null,
      enableTextSelection: true,
      enableDocumentLinkAnnotation: true,
      enableHyperlinkNavigation: true,
      initialZoomLevel: 1.2,
      maxZoomLevel: 2.5,
      backgroundColor: Colors.white,
      loadingWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: FCPColorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Loading asset PDF...',
              style: TextStyle(color: FCPColorScheme.neutral700, fontSize: 16),
            ),
          ],
        ),
      ),
      errorWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: FCPColorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Asset PDF not found',
              style: TextStyle(
                color: FCPColorScheme.error,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please add the PDF to your assets folder',
              style: TextStyle(color: FCPColorScheme.neutral600, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onDocumentLoaded: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Asset PDF loaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onDocumentLoadFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Asset PDF failed to load: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      onPageChanged: (pageNumber) {
        setState(() {
          _currentPage = pageNumber;
        });
      },
      onZoomLevelChanged: (zoomLevel) {
        setState(() {
          _currentZoom = zoomLevel;
        });
      },
    );
  }
}

/// Example page demonstrating a simple PDF viewer
class SimplePdfViewerExample extends StatelessWidget {
  const SimplePdfViewerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple PDF Viewer'),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: const FCPPdfViewer(
        pdfType: FCPPdfType.network,
        pdfUrl:
            'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        showZoomControls: true,
        showPageNavigationControls: true,
        enableTextSelection: true,
      ),
    );
  }
}

/// Example page demonstrating PDF viewer with custom controls
class CustomPdfViewerExample extends StatefulWidget {
  const CustomPdfViewerExample({super.key});

  @override
  State<CustomPdfViewerExample> createState() => _CustomPdfViewerExampleState();
}

class _CustomPdfViewerExampleState extends State<CustomPdfViewerExample> {
  late PdfViewerController _controller;
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom PDF Viewer'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _controller.searchText('sample');
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              _controller.zoomLevel = _controller.zoomLevel + 0.25;
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _controller.zoomLevel = _controller.zoomLevel - 0.25;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Custom page indicator
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.deepPurple.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page $_currentPage of $_totalPages',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.first_page),
                      onPressed: () => _controller.jumpToPage(1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => _controller.previousPage(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => _controller.nextPage(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.last_page),
                      onPressed: () => _controller.jumpToPage(_totalPages),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // PDF Viewer
          Expanded(
            child: FCPPdfViewer(
              pdfType: FCPPdfType.network,
              pdfUrl: 'https://heyzine.com/flip-book/94dbfed300.html',
              // pdfUrl:
              // 'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
              controller: _controller,
              showZoomControls: false,
              showPageNavigationControls: false,
              showSearch: false,
              backgroundColor: Colors.white,
              onDocumentLoaded: () {
                // Get total pages when document is loaded
                setState(() {
                  _totalPages = _controller.pageCount;
                });
              },
              onPageChanged: (pageNumber) {
                setState(() {
                  _currentPage = pageNumber;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
