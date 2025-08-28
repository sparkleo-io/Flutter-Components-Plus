import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components_controller.dart';
import '../../../button_examples.dart';
import '../../../input_field_examples.dart';
import '../../../card_examples.dart';
import '../../../dropdown_examples.dart';
import '../../../multi_select_examples.dart';
import '../../../bottom_navigation_examples.dart';
import '../../../pdf_viewer_examples.dart';

class ComponentsView extends GetView<ComponentsController> {
  const ComponentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Components Plus - Examples'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Buttons', icon: Icon(Icons.smart_button)),
              Tab(text: 'Input Fields', icon: Icon(Icons.input)),
              Tab(text: 'Cards', icon: Icon(Icons.credit_card)),
              Tab(text: 'Dropdowns', icon: Icon(Icons.arrow_drop_down)),
              Tab(text: 'Multi-Select', icon: Icon(Icons.checklist)),
              Tab(text: 'Navigation', icon: Icon(Icons.navigation)),
              Tab(text: 'PDF Viewer', icon: Icon(Icons.picture_as_pdf)),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: const TabBarView(
          children: [
            FCPButtonExamples(),
            FCPInputFieldExamples(),
            CardExamples(),
            FCPDropdownExamples(),
            FCPMultiSelectExamples(),
            BottomNavigationExamples(),
            PdfViewerExamples(),
          ],
        ),
      ),
    );
  }
}
