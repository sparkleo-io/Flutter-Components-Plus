# FCPPDFViewer Component

A powerful PDF viewer component with advanced features like zoom, scroll, search, and annotation support.

## Features

- **PDF Rendering**: High-quality PDF rendering with smooth scrolling
- **Zoom Controls**: Pinch-to-zoom and programmatic zoom controls
- **Search Functionality**: Built-in text search with highlighting
- **Navigation**: Page navigation with thumbnails and page indicators
- **Annotations**: Support for text highlighting and notes
- **Bookmarks**: Save and manage bookmarks
- **Accessibility**: Screen reader support and keyboard navigation
- **Responsive**: Automatic sizing and responsive design

## Basic Usage

### Simple PDF Viewer
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  onPageChanged: (page) {
    print('Page changed to: $page');
  },
)
```

### PDF Viewer with Custom Styling
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  backgroundColor: Colors.grey[100],
  showPageIndicator: true,
  showZoomControls: true,
  showSearchBar: true,
  enableAnnotation: true,
  onPageChanged: (page) {
    print('Page changed to: $page');
  },
)
```

### PDF Viewer with Search
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  showSearchBar: true,
  searchHighlightColor: Colors.yellow,
  onSearchResult: (result) {
    print('Search result: $result');
  },
)
```

## Advanced Usage

### PDF Viewer with Custom Controls
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  showPageIndicator: true,
  showZoomControls: true,
  showSearchBar: true,
  showBookmarkButton: true,
  showAnnotationButton: true,
  pageIndicatorStyle: FCPPageIndicatorStyle(
    backgroundColor: Colors.black.withOpacity(0.7),
    textColor: Colors.white,
    borderRadius: 20,
  ),
  zoomControlsStyle: FCPZoomControlsStyle(
    backgroundColor: Colors.blue,
    iconColor: Colors.white,
    borderRadius: 8,
  ),
)
```

### PDF Viewer with Annotations
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  enableAnnotation: true,
  annotationTypes: [
    FCPAnnotationType.highlight,
    FCPAnnotationType.note,
    FCPAnnotationType.underline,
  ],
  onAnnotationAdded: (annotation) {
    print('Annotation added: $annotation');
  },
  onAnnotationRemoved: (annotation) {
    print('Annotation removed: $annotation');
  },
)
```

### PDF Viewer with Bookmarks
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  showBookmarkButton: true,
  bookmarks: [
    FCPBookmark(page: 0, title: 'Cover'),
    FCPBookmark(page: 5, title: 'Introduction'),
    FCPBookmark(page: 10, title: 'Chapter 1'),
  ],
  onBookmarkAdded: (bookmark) {
    print('Bookmark added: $bookmark');
  },
  onBookmarkRemoved: (bookmark) {
    print('Bookmark removed: $bookmark');
  },
)
```

### PDF Viewer with Custom Theme
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  theme: FCPPDFViewerTheme(
    backgroundColor: Colors.grey[900],
    textColor: Colors.white,
    highlightColor: Colors.yellow,
    selectionColor: Colors.blue,
    toolbarColor: Colors.grey[800],
    toolbarTextColor: Colors.white,
  ),
)
```

### PDF Viewer with Loading States
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  loadingWidget: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading PDF...'),
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
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Retry loading
          },
          child: Text('Retry'),
        ),
      ],
    ),
  ),
)
```

### PDF Viewer with Custom Toolbar
```dart
FCPPDFViewer(
  pdfPath: 'assets/sample.pdf',
  showToolbar: true,
  toolbarItems: [
    FCPToolbarItem(
      icon: Icons.zoom_in,
      onTap: () {
        // Zoom in
      },
    ),
    FCPToolbarItem(
      icon: Icons.zoom_out,
      onTap: () {
        // Zoom out
      },
    ),
    FCPToolbarItem(
      icon: Icons.search,
      onTap: () {
        // Search
      },
    ),
    FCPToolbarItem(
      icon: Icons.bookmark,
      onTap: () {
        // Add bookmark
      },
    ),
  ],
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class PDFViewerExample extends StatefulWidget {
  @override
  _PDFViewerExampleState createState() => _PDFViewerExampleState();
}

class _PDFViewerExampleState extends State<PDFViewerExample> {
  String? _pdfPath;
  List<FCPBookmark> _bookmarks = [];
  List<FCPAnnotation> _annotations = [];

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  void _loadPDF() {
    // Load PDF from assets or network
    setState(() {
      _pdfPath = 'assets/sample.pdf';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Show bookmarks
            },
          ),
        ],
      ),
      body: _pdfPath != null
          ? FCPPDFViewer(
              pdfPath: _pdfPath!,
              backgroundColor: Colors.grey[100],
              showPageIndicator: true,
              showZoomControls: true,
              showSearchBar: true,
              showBookmarkButton: true,
              showAnnotationButton: true,
              enableAnnotation: true,
              bookmarks: _bookmarks,
              annotations: _annotations,
              onPageChanged: (page) {
                print('Page changed to: $page');
              },
              onBookmarkAdded: (bookmark) {
                setState(() {
                  _bookmarks.add(bookmark);
                });
              },
              onBookmarkRemoved: (bookmark) {
                setState(() {
                  _bookmarks.remove(bookmark);
                });
              },
              onAnnotationAdded: (annotation) {
                setState(() {
                  _annotations.add(annotation);
                });
              },
              onAnnotationRemoved: (annotation) {
                setState(() {
                  _annotations.remove(annotation);
                });
              },
              onSearchResult: (result) {
                print('Search result: $result');
              },
              theme: FCPPDFViewerTheme(
                backgroundColor: Colors.white,
                textColor: Colors.black,
                highlightColor: Colors.yellow,
                selectionColor: Colors.blue,
                toolbarColor: Colors.grey[200],
                toolbarTextColor: Colors.black,
              ),
              pageIndicatorStyle: FCPPageIndicatorStyle(
                backgroundColor: Colors.black.withOpacity(0.7),
                textColor: Colors.white,
                borderRadius: 20,
              ),
              zoomControlsStyle: FCPZoomControlsStyle(
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
                borderRadius: 8,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading PDF...'),
                ],
              ),
            ),
    );
  }
}
```

## API Reference

### FCPPDFViewer Properties

| Property | Type | Description |
|----------|--------|-------------|
| `pdfPath` | `String` | Path to PDF file |
| `backgroundColor` | `Color?` | Background color |
| `showPageIndicator` | `bool` | Show page indicator |
| `showZoomControls` | `bool` | Show zoom controls |
| `showSearchBar` | `bool` | Show search bar |
| `showBookmarkButton` | `bool` | Show bookmark button |
| `showAnnotationButton` | `bool` | Show annotation button |
| `enableAnnotation` | `bool` | Enable annotations |
| `bookmarks` | `List<FCPBookmark>?` | List of bookmarks |
| `annotations` | `List<FCPAnnotation>?` | List of annotations |
| `onPageChanged` | `Function(int)?` | Page change callback |
| `onBookmarkAdded` | `Function(FCPBookmark)?` | Bookmark added callback |
| `onBookmarkRemoved` | `Function(FCPBookmark)?` | Bookmark removed callback |
| `onAnnotationAdded` | `Function(FCPAnnotation)?` | Annotation added callback |
| `onAnnotationRemoved` | `Function(FCPAnnotation)?` | Annotation removed callback |
| `onSearchResult` | `Function(FCPSearchResult)?` | Search result callback |
| `theme` | `FCPPDFViewerTheme?` | Custom theme |
| `pageIndicatorStyle` | `FCPPageIndicatorStyle?` | Page indicator style |
| `zoomControlsStyle` | `FCPZoomControlsStyle?` | Zoom controls style |
| `loadingWidget` | `Widget?` | Loading widget |
| `errorWidget` | `Widget?` | Error widget |

### FCPPDFViewerTheme Properties

| Property | Type | Description |
|----------|--------|-------------|
| `backgroundColor` | `Color?` | Background color |
| `textColor` | `Color?` | Text color |
| `highlightColor` | `Color?` | Highlight color |
| `selectionColor` | `Color?` | Selection color |
| `toolbarColor` | `Color?` | Toolbar color |
| `toolbarTextColor` | `Color?` | Toolbar text color |

### FCPPageIndicatorStyle Properties

| Property | Type | Description |
|----------|--------|-------------|
| `backgroundColor` | `Color?` | Background color |
| `textColor` | `Color?` | Text color |
| `borderRadius` | `double?` | Border radius |
| `padding` | `EdgeInsetsGeometry?` | Padding |
| `margin` | `EdgeInsetsGeometry?` | Margin |

### FCPZoomControlsStyle Properties

| Property | Type | Description |
|----------|--------|-------------|
| `backgroundColor` | `Color?` | Background color |
| `iconColor` | `Color?` | Icon color |
| `borderRadius` | `double?` | Border radius |
| `padding` | `EdgeInsetsGeometry?` | Padding |
| `margin` | `EdgeInsetsGeometry?` | Margin |

### FCPBookmark Properties

| Property | Type | Description |
|----------|--------|-------------|
| `page` | `int` | Page number |
| `title` | `String` | Bookmark title |
| `description` | `String?` | Bookmark description |
| `createdAt` | `DateTime?` | Creation date |

### FCPAnnotation Properties

| Property | Type | Description |
|----------|--------|-------------|
| `id` | `String` | Annotation ID |
| `page` | `int` | Page number |
| `type` | `FCPAnnotationType` | Annotation type |
| `content` | `String?` | Annotation content |
| `position` | `Rect` | Annotation position |
| `color` | `Color?` | Annotation color |
| `createdAt` | `DateTime?` | Creation date |

### FCPAnnotationType

| Type | Description |
|------|-------------|
| `highlight` | Text highlighting |
| `note` | Text note |
| `underline` | Text underline |
| `strikethrough` | Text strikethrough |
| `freehand` | Freehand drawing |

### FCPSearchResult Properties

| Property | Type | Description |
|----------|--------|-------------|
| `query` | `String` | Search query |
| `page` | `int` | Page number |
| `position` | `Rect` | Text position |
| `context` | `String?` | Surrounding text |

## Best Practices

1. **File Size**: Optimize PDF files for better performance
2. **Loading States**: Always show loading indicators
3. **Error Handling**: Provide clear error messages and retry options
4. **Accessibility**: Ensure proper labels and descriptions
5. **Performance**: Use appropriate zoom levels and page caching
6. **User Experience**: Provide intuitive navigation and controls
7. **Memory Management**: Properly dispose of resources when not needed

## Accessibility

- All PDF viewer controls support proper touch targets
- Screen reader support for PDF content and controls
- Keyboard navigation support
- High contrast mode support
- Proper semantic structure for assistive technologies
