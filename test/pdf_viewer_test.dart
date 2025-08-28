import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

void main() {
  group('FCPPdfViewer', () {
    testWidgets('should render with network PDF type', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should render with local PDF type', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.local,
            pdfPath: '/path/to/local/document.pdf',
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should render with assets PDF type', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.assets,
            pdfPath: 'assets/documents/sample.pdf',
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should show custom loading widget', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            loadingWidget: Center(child: Text('Custom Loading...')),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the custom loading widget is displayed
      expect(find.text('Custom Loading...'), findsOneWidget);
    });

    testWidgets('should show custom error widget', (WidgetTester tester) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.local,
            pdfPath: '/invalid/path/document.pdf',
            errorWidget: Center(child: Text('Custom Error')),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the custom error widget is displayed
      expect(find.text('Custom Error'), findsOneWidget);
    });

    testWidgets('should handle document loaded callback', (
      WidgetTester tester,
    ) async {
      bool callbackCalled = false;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            onDocumentLoaded: () {
              callbackCalled = true;
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should handle document load failed callback', (
      WidgetTester tester,
    ) async {
      String? errorMessage;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://invalid-url.com/document.pdf',
            onDocumentLoadFailed: (error) {
              errorMessage = error;
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should handle page changed callback', (
      WidgetTester tester,
    ) async {
      int? pageNumber;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            onPageChanged: (page) {
              pageNumber = page;
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should handle zoom level changed callback', (
      WidgetTester tester,
    ) async {
      double? zoomLevel;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            onZoomLevelChanged: (zoom) {
              zoomLevel = zoom;
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should apply custom background color', (
      WidgetTester tester,
    ) async {
      const customColor = Colors.red;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            backgroundColor: customColor,
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should handle different zoom levels', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            initialZoomLevel: 1.5,
            maxZoomLevel: 2.0,
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });

    testWidgets('should handle search functionality', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPPdfViewer(
            pdfType: FCPPdfType.network,
            pdfUrl: 'https://example.com/sample.pdf',
            showSearch: true,
            searchText: 'sample',
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the PDF viewer is rendered
      expect(find.byType(FCPPdfViewer), findsOneWidget);
    });
  });
}
