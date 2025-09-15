import 'package:flutter/material.dart';
import 'package:flutter_component_plus_example/multi_inline_dropdown_examples.dart';
import 'package:get/get.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'home_controller.dart';
import '../theme/theme_controller.dart';
import '../../../input_field_examples.dart';
import '../../../card_examples.dart';
import '../../../dropdown_examples.dart';
import '../../../multi_select_examples.dart';
import '../../../inline_dropdown_examples.dart';
import '../../../pdf_viewer_examples.dart';
import '../../../table_examples.dart';
import '../../../switch_examples.dart';
import '../../../chart_examples.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Components Plus'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Desktop layout
            return Row(
              children: [
                // Sidebar
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  child: _buildSidebar(context),
                ),
                // Main content
                Expanded(child: _buildMainContent(context)),
              ],
            );
          } else {
            // Mobile layout with bottom navigation
            return Column(
              children: [
                // Main content
                Expanded(child: _buildMainContent(context)),
                // Bottom Navigation Bar
                _buildBottomNavigationBar(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(FCPConstants.spacingMd),
      children: [
        const SizedBox(height: FCPConstants.spacingMd),
        _buildSidebarItem(context, 'Overview', Icons.dashboard, 0),
        _buildSidebarItem(context, 'Buttons', Icons.smart_button, 1),
        _buildSidebarItem(context, 'Cards', Icons.credit_card, 2),
        _buildSidebarItem(context, 'Inputs', Icons.input, 3),
        _buildSidebarItem(context, 'Dropdowns', Icons.arrow_drop_down, 4),
        _buildSidebarItem(context, 'Multi-Select', Icons.checklist, 5),
        _buildSidebarItem(context, 'Inline Dropdowns', Icons.expand_more, 6),
        _buildSidebarItem(
          context,
          'Multi-Inline Dropdowns',
          Icons.expand_more,
          7,
        ),
        _buildSidebarItem(context, 'Tables', Icons.table_chart, 8),
        _buildSidebarItem(context, 'Switches', Icons.toggle_on, 9),
        _buildSidebarItem(context, 'PDF Viewer', Icons.picture_as_pdf, 10),
        _buildSidebarItem(context, 'Charts', Icons.bar_chart, 11),
        _buildSidebarItem(context, 'Navigation', Icons.navigation, 13),
        _buildSidebarItem(context, 'Feedback', Icons.feedback, 14),
        _buildSidebarItem(context, 'Layout', Icons.grid_on, 15),
        _buildSidebarItem(context, 'LEO', Icons.developer_board, 16),
      ],
    );
  }

  Widget _buildSidebarItem(
    BuildContext context,
    String title,
    IconData icon,
    int index,
  ) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: FCPConstants.spacingSm),
        child: ListTile(
          leading: Icon(
            icon,
            color: controller.selectedTabIndex == index
                ? FCPColorScheme.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: controller.selectedTabIndex == index
                  ? FCPColorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: controller.selectedTabIndex == index
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
          onTap: () => controller.changeTab(index),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
          ),
          tileColor: controller.selectedTabIndex == index
              ? FCPColorScheme.primary.withValues(alpha: 0.1)
              : null,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 70,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildBottomNavItem(context, 'Overview', Icons.dashboard, 0),
                  _buildBottomNavItem(
                    context,
                    'Buttons',
                    Icons.smart_button,
                    1,
                  ),
                  _buildBottomNavItem(context, 'Cards', Icons.credit_card, 2),
                  _buildBottomNavItem(context, 'Inputs', Icons.input, 3),
                  _buildBottomNavItem(
                    context,
                    'Dropdowns',
                    Icons.arrow_drop_down,
                    4,
                  ),
                  _buildBottomNavItem(
                    context,
                    'Multi-Select',
                    Icons.checklist,
                    5,
                  ),
                  _buildBottomNavItem(context, 'Inline', Icons.expand_more, 6),
                  _buildBottomNavItem(
                    context,
                    'Multi-Inline',
                    Icons.expand_more,
                    7,
                  ),
                  _buildBottomNavItem(context, 'Tables', Icons.table_chart, 8),
                  _buildBottomNavItem(context, 'Switches', Icons.toggle_on, 9),
                  _buildBottomNavItem(context, 'PDF', Icons.picture_as_pdf, 10),
                  _buildBottomNavItem(context, 'Charts', Icons.bar_chart, 11),
                  _buildBottomNavItem(
                    context,
                    'Navigation',
                    Icons.navigation,
                    13,
                  ),
                  _buildBottomNavItem(context, 'Feedback', Icons.feedback, 14),
                  _buildBottomNavItem(context, 'Layout', Icons.grid_on, 15),
                  _buildBottomNavItem(
                    context,
                    'Leo',
                    Icons.developer_board,
                    16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context,
    String title,
    IconData icon,
    int index,
  ) {
    final isSelected = controller.selectedTabIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ), // Add spacing between items
      child: InkWell(
        onTap: () => controller.changeTab(index),
        borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Added to prevent overflow
            children: [
              Icon(
                icon,
                color: isSelected
                    ? FCPColorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                size: 22, // Slightly reduced icon size
              ),
              const SizedBox(height: 2), // Reduced spacing
              Flexible(
                // Added Flexible to handle text overflow
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10, // Reduced font size
                    color: isSelected
                        ? FCPColorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis, // Added overflow handling
                  maxLines: 1, // Limit to single line
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Obx(() {
      switch (controller.selectedTabIndex) {
        case 0:
          return _buildOverviewTab(context);
        case 1:
          return _buildButtonsTab(context);
        case 2:
          return _buildCardsTab(context);
        case 3:
          return _buildInputsTab(context);
        case 4:
          return _buildDropdownsTab(context);
        case 5:
          return _buildMultiSelectTab(context);
        case 6:
          return _buildInlineDropdownTab(context);
        case 7:
          return _buildMultiInlineDropdownTab(context);
        case 8:
          return _buildTablesTab(context);
        case 9:
          return _buildSwitchesTab(context);
        case 10:
          return _buildPdfViewerTab(context);
        case 11:
          return _buildChartsTab(context);
        case 12:
          return _buildNavigationTab(context);
        case 13:
          return _buildFeedbackTab(context);
        case 15:
          return _buildLayoutTab(context);
        default:
          return _buildOverviewTab(context);
      }
    });
  }

  Widget _buildOverviewTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(FCPConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flutter Components Plus',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: FCPConstants.spacingSm),
          Text(
            'A comprehensive collection of reusable Flutter components',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: FCPConstants.spacingXl),

          // Stats Grid
          _buildStatsGrid(context),
          const SizedBox(height: FCPConstants.spacingXl),

          // Quick Actions
          _buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid configuration
        int crossAxisCount;
        double childAspectRatio;
        double spacing;

        if (constraints.maxWidth < 400) {
          // Very small mobile
          crossAxisCount = 1;
          childAspectRatio = 3.5;
          spacing = 8.0;
        } else if (constraints.maxWidth < 600) {
          // Small mobile
          crossAxisCount = 2;
          childAspectRatio = 2.8;
          spacing = 12.0;
        } else if (constraints.maxWidth < 800) {
          // Medium mobile/tablet
          crossAxisCount = 2;
          childAspectRatio = 2.5;
          spacing = 16.0;
        } else {
          // Desktop
          crossAxisCount = 4;
          childAspectRatio = 2.0;
          spacing = 16.0;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
          children: [
            _buildStatCard(
              context,
              'Components',
              '60+',
              Icons.widgets,
              FCPColorScheme.primary,
            ),
            _buildStatCard(
              context,
              'Variants',
              '200+',
              Icons.style,
              FCPColorScheme.secondary,
            ),
            _buildStatCard(
              context,
              'Themes',
              '10+',
              Icons.palette,
              FCPColorScheme.success,
            ),
            _buildStatCard(
              context,
              'Examples',
              '100+',
              Icons.code,
              FCPColorScheme.warning,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(FCPConstants.spacingMd),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(FCPConstants.radiusLg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: FCPConstants.spacingSm),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: FCPConstants.spacingSm),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: FCPConstants.spacingMd),
        Wrap(
          spacing: FCPConstants.spacingMd,
          runSpacing: FCPConstants.spacingMd,
          children: [
            FCPButton.medium.primary(
              text: 'View Components',
              onPressed: () => controller.changeTab(1),
              icon: Icons.visibility,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.secondary(
              text: 'All Components',
              onPressed: () => Get.toNamed('/components'),
              icon: Icons.widgets,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.outlined(
              text: 'Multi-Select',
              onPressed: () => controller.changeTab(5),
              icon: Icons.checklist,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.outlined(
              text: 'Inline Dropdowns',
              onPressed: () => controller.changeTab(6),
              icon: Icons.expand_more,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.outlined(
              text: 'Charts',
              onPressed: () => controller.changeTab(11),
              icon: Icons.bar_chart,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.outlined(
              text: 'Documentation',
              onPressed: () {},
              icon: Icons.description,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.ghost(
              text: 'GitHub',
              onPressed: () {},
              icon: Icons.code,
              iconPosition: IconPosition.start,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(FCPConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button Components',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: FCPConstants.spacingLg),

          // Button Variants
          _buildSection(context, 'Button Variants', _buildButtonVariants()),
          const SizedBox(height: FCPConstants.spacingXl),

          // Button Sizes
          _buildSection(context, 'Button Sizes', _buildButtonSizes()),
          const SizedBox(height: FCPConstants.spacingXl),

          // Button States
          _buildSection(context, 'Button States', _buildButtonStates()),
          const SizedBox(height: FCPConstants.spacingXl),

          // Interactive Examples
          _buildSection(
            context,
            'Interactive Examples',
            _buildInteractiveExamples(context),
          ),
          const SizedBox(height: FCPConstants.spacingXl),

          // Button with Icons
          _buildSection(context, 'Buttons with Icons', _buildButtonWithIcons()),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: FCPConstants.spacingMd),
        Container(
          padding: const EdgeInsets.all(FCPConstants.spacingLg),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(FCPConstants.radiusLg),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: content,
        ),
      ],
    );
  }

  Widget _buildButtonVariants() {
    return Wrap(
      spacing: FCPConstants.spacingMd,
      runSpacing: FCPConstants.spacingMd,
      children: [
        FCPButton.medium.primary(text: 'Primary', onPressed: () {}),
        FCPButton.medium.secondary(text: 'Secondary', onPressed: () {}),
        FCPButton.medium.outlined(text: 'Outline', onPressed: () {}),
        FCPButton.medium.ghost(text: 'Ghost', onPressed: () {}),
        FCPButton.medium.danger(text: 'Danger', onPressed: () {}),
      ],
    );
  }

  Widget _buildButtonSizes() {
    return Wrap(
      spacing: FCPConstants.spacingMd,
      runSpacing: FCPConstants.spacingMd,
      children: [
        FCPButton.small.primary(text: 'Small', onPressed: () {}),
        FCPButton.medium.primary(text: 'Medium', onPressed: () {}),
        FCPButton.large.primary(text: 'Large', onPressed: () {}),
        FCPButton.extraLarge.primary(text: 'Extra Large', onPressed: () {}),
      ],
    );
  }

  Widget _buildButtonStates() {
    return Wrap(
      spacing: FCPConstants.spacingMd,
      runSpacing: FCPConstants.spacingMd,
      children: [
        FCPButton.medium.primary(text: 'Normal', onPressed: () {}),
        FCPButton.medium.primary(
          text: 'Static Loading',
          onPressed: () {},
          isLoading: true,
        ),
        FCPButton.medium.primary(
          text: 'Disabled',
          onPressed: () {},
          isDisabled: true,
        ),
      ],
    );
  }

  Widget _buildInteractiveExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Try clicking the button below to see the loading state in action:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: FCPConstants.spacingMd),
        Wrap(
          spacing: FCPConstants.spacingMd,
          runSpacing: FCPConstants.spacingMd,
          children: [
            Obx(
              () => FCPButton.medium.primary(
                text: 'Start Loading (2s)',
                onPressed: controller.isLoading
                    ? null
                    : controller.startLoading,
                isLoading: controller.isLoading,
                icon: Icons.download,
                iconPosition: IconPosition.start,
              ),
            ),
            Obx(
              () => FCPButton.medium.secondary(
                text: 'Loading with Icon',
                onPressed: controller.isLoading
                    ? null
                    : controller.startLoading,
                isLoading: controller.isLoading,
                icon: Icons.refresh,
                iconPosition: IconPosition.start,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonWithIcons() {
    return Wrap(
      spacing: FCPConstants.spacingMd,
      runSpacing: FCPConstants.spacingMd,
      children: [
        FCPButton.medium.primary(
          text: 'Start Icon',
          onPressed: () {},
          icon: Icons.star,
          iconPosition: IconPosition.start,
        ),
        FCPButton.medium.primary(
          text: 'End Icon',
          onPressed: () {},
          icon: Icons.arrow_forward,
        ),
        FCPButton.medium.iconButton(icon: Icons.favorite, onPressed: () {}),
      ],
    );
  }

  Widget _buildCardsTab(BuildContext context) {
    return const CardExamples();
  }

  Widget _buildInputsTab(BuildContext context) {
    return const FCPInputFieldExamples();
  }

  Widget _buildDropdownsTab(BuildContext context) {
    return const FCPDropdownExamples();
  }

  Widget _buildMultiSelectTab(BuildContext context) {
    return const FCPMultiSelectExamples();
  }

  Widget _buildInlineDropdownTab(BuildContext context) {
    return const FCPInlineDropdownExamples();
  }

  Widget _buildMultiInlineDropdownTab(BuildContext context) {
    return const MultiInlineDropdownExamples();
  }

  Widget _buildTablesTab(BuildContext context) {
    return const TableExamples();
  }

  Widget _buildSwitchesTab(BuildContext context) {
    return const SwitchExamplesPage();
  }

  Widget _buildPdfViewerTab(BuildContext context) {
    return const PdfViewerExamples();
  }

  Widget _buildChartsTab(BuildContext context) {
    return const FCPChartExamples();
  }

  Widget _buildNavigationTab(BuildContext context) {
    return const Center(child: Text('Navigation Tab - Coming Soon'));
  }

  Widget _buildFeedbackTab(BuildContext context) {
    return const Center(child: Text('Feedback Tab - Coming Soon'));
  }

  Widget _buildLayoutTab(BuildContext context) {
    return const Center(child: Text('Layout Tab - Coming Soon'));
  }
}
