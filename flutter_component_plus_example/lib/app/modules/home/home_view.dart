import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'home_controller.dart';
import '../theme/theme_controller.dart';

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
            // Mobile layout
            return Column(
              children: [
                // Tab bar for mobile
                _buildMobileTabBar(context),
                // Main content
                Expanded(child: _buildMainContent(context)),
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
        _buildSidebarItem(context, 'Navigation', Icons.navigation, 4),
        _buildSidebarItem(context, 'Feedback', Icons.feedback, 5),
        _buildSidebarItem(context, 'Layout', Icons.grid_on, 6),
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

  Widget _buildMobileTabBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Obx(
        () => Row(
          children: [
            _buildMobileTabItem(context, 'Overview', Icons.dashboard, 0),
            _buildMobileTabItem(context, 'Buttons', Icons.smart_button, 1),
            _buildMobileTabItem(context, 'Cards', Icons.credit_card, 2),
            _buildMobileTabItem(context, 'More', Icons.more_horiz, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileTabItem(
    BuildContext context,
    String title,
    IconData icon,
    int index,
  ) {
    final isSelected = controller.selectedTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => controller.changeTab(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? FCPColorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? FCPColorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
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
          return _buildNavigationTab(context);
        case 5:
          return _buildFeedbackTab(context);
        case 6:
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
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
      crossAxisSpacing: FCPConstants.spacingMd,
      mainAxisSpacing: FCPConstants.spacingMd,
      childAspectRatio: 2.5,
      children: [
        _buildStatCard(
          context,
          'Components',
          '50+',
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
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: FCPConstants.spacingSm),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
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
              text: 'Documentation',
              onPressed: () {},
              icon: Icons.description,
              iconPosition: IconPosition.start,
            ),
            FCPButton.medium.outlined(
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
    return const Center(child: Text('Cards Tab - Coming Soon'));
  }

  Widget _buildInputsTab(BuildContext context) {
    return const Center(child: Text('Inputs Tab - Coming Soon'));
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
