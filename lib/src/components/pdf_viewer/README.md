# PDF Viewer Components

This directory contains PDF viewer components for the Flutter Components Plus package.

## Components

### FCPPdfViewer

A comprehensive PDF viewer component with enhanced features for displaying PDF documents from various sources.

#### Features

- **Multiple Source Support**: Load PDFs from local files, network URLs, or app assets
- **Enhanced Controls**: Built-in zoom controls, page navigation, and search functionality
- **Customizable UI**: Custom loading and error states with theme integration
- **Interactive Features**: Text selection, document links, and hyperlink navigation
- **Event Callbacks**: Comprehensive event handling for document loading, page changes, and zoom
- **Accessibility**: Built-in accessibility support with proper semantics
- **Error Handling**: Robust error handling with retry functionality

#### Usage

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';

class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfViewerController _controller;
  int _currentPage = 1;
  double _currentZoom = 1.0;

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
        title: Text('PDF Viewer'),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Page and zoom info
          Container(
            padding: EdgeInsets.all(16),
            color: FCPColorScheme.neutral100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Page: $_currentPage'),
                Text('Zoom: ${(_currentZoom * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          // PDF Viewer
          Expanded(
            child: FCPPdfViewer(
              pdfType: FCPPdfType.network,
              pdfUrl: 'https://example.com/sample.pdf',
              controller: _controller,
              showZoomControls: true,
              showPageNavigationControls: true,
              showSearch: true,
              searchText: 'sample',
              onDocumentLoaded: () {
                print('PDF loaded successfully');
              },
              onDocumentLoadFailed: (error) {
                print('PDF failed to load: $error');
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
            ),
          ),
        ],
      ),
    );
  }
}
```

#### Local PDF Example

```dart
FCPPdfViewer(
  pdfType: FCPPdfType.local,
  pdfPath: '/path/to/local/document.pdf',
  showZoomControls: true,
  enableTextSelection: true,
  onDocumentLoaded: () => print('Local PDF loaded'),
)
```

#### Asset PDF Example

```dart
FCPPdfViewer(
  pdfType: FCPPdfType.assets,
  pdfPath: 'assets/documents/sample.pdf',
  showZoomControls: false,
  showPageNavigationControls: true,
  backgroundColor: Colors.grey[100],
)
```

#### Custom Loading and Error States

```dart
FCPPdfViewer(
  pdfType: FCPPdfType.network,
  pdfUrl: 'https://example.com/document.pdf',
  loadingWidget: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading your document...'),
      ],
    ),
  ),
  errorWidget: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 64, color: Colors.red),
        SizedBox(height: 16),
        Text('Failed to load PDF'),
        ElevatedButton(
          onPressed: () {
            // Retry logic
          },
          child: Text('Retry'),
        ),
      ],
    ),
  ),
)
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `pdfType` | `FCPPdfType` | Yes | Type of PDF source (local, network, assets) |
| `pdfUrl` | `String?` | No | URL for network PDF |
| `pdfPath` | `String?` | No | Local file path or asset path |
| `pdfViewerKey` | `GlobalKey?` | No | Global key for the PDF viewer |
| `showZoomControls` | `bool` | No | Whether to show zoom controls (default: true) |
| `showScrollHead` | `bool` | No | Whether to show scroll head (default: true) |
| `enableTextSelection` | `bool` | No | Whether to enable text selection (default: true) |
| `enableDocumentLinkAnnotation` | `bool` | No | Whether to enable document link annotation (default: true) |
| `enableHyperlinkNavigation` | `bool` | No | Whether to enable hyperlink navigation (default: true) |
| `initialZoomLevel` | `double` | No | Initial zoom level (default: 1.0) |
| `maxZoomLevel` | `double` | No | Maximum zoom level (default: 3.0) |
| `minZoomLevel` | `double` | No | Minimum zoom level (default: 0.25) |
| `backgroundColor` | `Color?` | No | Background color of the PDF viewer |
| `loadingWidget` | `Widget?` | No | Custom loading widget |
| `errorWidget` | `Widget?` | No | Custom error widget |
| `onDocumentLoaded` | `VoidCallback?` | No | Callback when PDF loads successfully |
| `onDocumentLoadFailed` | `Function(String)?` | No | Callback when PDF fails to load |
| `onPageChanged` | `Function(int)?` | No | Callback when page changes |
| `onZoomLevelChanged` | `Function(double)?` | No | Callback when zoom level changes |
| `controller` | `PdfViewerController?` | No | Custom PDF viewer controller |
| `showPageNavigationControls` | `bool` | No | Whether to show page navigation controls (default: true) |
| `showSearch` | `bool` | No | Whether to show search functionality (default: true) |
| `searchText` | `String?` | No | Text to search and highlight |

#### PDF Types

- **`FCPPdfType.local`**: Load PDF from local file system
- **`FCPPdfType.network`**: Load PDF from network URL
- **`FCPPdfType.assets`**: Load PDF from app assets

#### Controller Methods

```dart
final controller = PdfViewerController();

// Navigation
controller.nextPage();
controller.previousPage();
controller.jumpToPage(pageNumber);

// Zoom
controller.zoomLevel = 1.5;
controller.zoomToPage();

// Search
controller.searchText('search term');
controller.clearSearch();

// Scroll
controller.scrollToOffset(offset);
controller.scrollToPage(pageNumber);
```

#### Asset Configuration

To use PDF files from assets, add them to your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/documents/
    - assets/pdfs/
```

#### Best Practices

1. **File Validation**: Always check if local files exist before loading
2. **Error Handling**: Implement proper error handling for network PDFs
3. **Memory Management**: Dispose controllers when not needed
4. **Loading States**: Provide meaningful loading indicators
5. **Accessibility**: Ensure PDF content is accessible to screen readers
6. **Performance**: Use appropriate zoom levels for large documents
7. **Network**: Handle network connectivity issues gracefully
8. **Caching**: Consider implementing PDF caching for better performance

#### Platform Considerations

- **iOS**: Requires internet permission for network PDFs
- **Android**: Requires internet permission for network PDFs
- **Web**: Limited support for local file access
- **Desktop**: Full support for all PDF types

#### Dependencies

The PDF viewer requires the following dependency:
```yaml
dependencies:
  syncfusion_flutter_pdfviewer: ^24.2.9
```

#### License

This component uses Syncfusion Flutter PDF Viewer, which requires a valid license for commercial use. See [Syncfusion Licensing](https://www.syncfusion.com/licensing) for more details.
