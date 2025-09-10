import 'package:flutter/material.dart';
import 'package:flutter_component_plus_example/table_examples.dart';
import 'package:get/get.dart';
import 'components_controller.dart';
import '../../controllers/table_examples_controller.dart';
import '../../../button_examples.dart';
import '../../../input_field_examples.dart';
import '../../../card_examples.dart';
import '../../../dropdown_examples.dart';
import '../../../multi_select_examples.dart';
import '../../../inline_dropdown_examples.dart';
import '../../../multi_inline_dropdown_examples.dart';
import '../../../bottom_navigation_examples.dart';
import '../../../pdf_viewer_examples.dart';
import '../../../switch_examples.dart';
import '../../../chart_examples.dart';
import '../../../ble_service_examples.dart';
import '../../../ble_permission_examples.dart';
import '../../../ble_scan_examples.dart';
import '../../../ble_comprehensive_examples.dart';

class ComponentsView extends GetView<ComponentsController> {
  const ComponentsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize table examples controller when this view is built
    Get.lazyPut<TableExamplesController>(() => TableExamplesController());

    return DefaultTabController(
      length: 16,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Components Plus - Examples'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabBar(
                isScrollable: true, // Make tabs scrollable on small screens
                tabs: [
                  Tab(text: 'Buttons', icon: Icon(Icons.smart_button)),
                  Tab(text: 'Inputs', icon: Icon(Icons.input)), // Shortened
                  Tab(text: 'Cards', icon: Icon(Icons.credit_card)),
                  Tab(text: 'Dropdowns', icon: Icon(Icons.arrow_drop_down)),
                  Tab(text: 'Multi-Select', icon: Icon(Icons.checklist)),
                  Tab(
                    text: 'Inline',
                    icon: Icon(Icons.expand_more),
                  ), // Shortened
                  Tab(text: 'Multi Inline', icon: Icon(Icons.checklist_rtl)),
                  Tab(text: 'Navigation', icon: Icon(Icons.navigation)),
                  Tab(text: 'Switches', icon: Icon(Icons.toggle_on)),
                  Tab(
                    text: 'PDF',
                    icon: Icon(Icons.picture_as_pdf),
                  ), // Shortened
                  Tab(text: 'Charts', icon: Icon(Icons.bar_chart)),
                  Tab(text: 'Tables', icon: Icon(Icons.table_chart)),
                  Tab(text: 'BLE Service', icon: Icon(Icons.bluetooth)),
                  Tab(text: 'BLE Permissions', icon: Icon(Icons.security)),
                  Tab(text: 'BLE Scan Config', icon: Icon(Icons.radar)),
                  Tab(
                    text: 'BLE Comprehensive',
                    icon: Icon(Icons.integration_instructions),
                  ),
                ],
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FCPButtonExamples(),
            FCPInputFieldExamples(),
            CardExamples(),
            FCPDropdownExamples(),
            FCPMultiSelectExamples(),
            FCPInlineDropdownExamples(),
            MultiInlineDropdownExamples(),
            BottomNavigationExamples(),
            SwitchExamplesPage(),
            PdfViewerExamples(),
            FCPChartExamples(),
            TableExamples(),
            BLEServiceExamples(),
            BLEPermissionExamples(),
            BLEScanExamples(),
            BLEComprehensiveExamples(),
          ],
        ),
      ),
    );
  }
}
