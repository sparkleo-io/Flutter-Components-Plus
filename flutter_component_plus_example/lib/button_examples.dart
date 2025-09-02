import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Comprehensive examples of FCPButton usage with the fluent API
class FCPButtonExamples extends StatelessWidget {
  const FCPButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FCPButton Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Primary Buttons', [
              FCPButton.small.primary(text: 'Small Primary', onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.medium.primary(
                text: 'Medium Primary',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.primary(text: 'Large Primary', onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.extraLarge.primary(
                text: 'Extra Large Primary',
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Secondary Buttons', [
              FCPButton.small.secondary(
                text: 'Small Secondary',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.secondary(
                text: 'Medium Secondary',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.secondary(
                text: 'Large Secondary',
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Outlined Buttons', [
              FCPButton.small.outlined(
                text: 'Small Outlined',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.outlined(
                text: 'Medium Outlined',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.outlined(
                text: 'Large Outlined',
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Ghost Buttons', [
              FCPButton.small.ghost(text: 'Small Ghost', onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.medium.ghost(text: 'Medium Ghost', onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.large.ghost(text: 'Large Ghost', onPressed: () {}),
            ]),

            const SizedBox(height: 24),
            _buildSection('Danger Buttons', [
              FCPButton.small.danger(text: 'Small Danger', onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.medium.danger(text: 'Medium Danger', onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.large.danger(text: 'Large Danger', onPressed: () {}),
            ]),

            const SizedBox(height: 24),
            _buildSection('Icon Buttons', [
              Row(
                children: [
                  FCPButton.small.iconButton(icon: Icons.add, onPressed: () {}),
                  const SizedBox(width: 8),
                  FCPButton.medium.iconButton(
                    icon: Icons.edit,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  FCPButton.large.iconButton(
                    icon: Icons.delete,
                    onPressed: () {},
                  ),
                ],
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Icon with Text Buttons', [
              FCPButton.small.primary(
                text: 'Add Item',
                icon: Icons.add,
                iconPosition: IconPosition.start,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.secondary(
                text: 'Edit Profile',
                icon: Icons.edit,
                iconPosition: IconPosition.end,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.outlined(
                text: 'Download',
                icon: Icons.download,
                iconPosition: IconPosition.start,
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Floating Buttons', [
              FCPButton.small.floating(icon: Icons.add, onPressed: () {}),
              const SizedBox(height: 8),
              FCPButton.medium.floating(
                text: 'Add',
                icon: Icons.add,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.floating(
                text: 'Create New',
                icon: Icons.create,
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Elevated Buttons', [
              FCPButton.small.elevated(
                text: 'Small Elevated',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.elevated(
                text: 'Medium Elevated',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.elevated(
                text: 'Large Elevated',
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Contained Buttons', [
              FCPButton.small.contained(
                text: 'Small Contained',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.contained(
                text: 'Medium Contained',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.large.contained(
                text: 'Large Contained',
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Loading States', [
              FCPButton.medium.primary(
                text: 'Loading...',
                isLoading: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.outlined(
                text: 'Loading...',
                isLoading: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.iconButton(
                icon: Icons.refresh,
                isLoading: true,
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Disabled States', [
              FCPButton.medium.primary(
                text: 'Disabled',
                isDisabled: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.outlined(
                text: 'Disabled',
                isDisabled: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              FCPButton.medium.iconButton(
                icon: Icons.delete,
                isDisabled: true,
                onPressed: () {},
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Custom Styling', [
              FCPButton.medium.primary(
                text: 'Custom Colors',
                backgroundColor: Colors.purple,
                foregroundColor: Colors.yellow,
                borderRadius: 20,
                elevation: 8,
              ),
              const SizedBox(height: 8),
              FCPButton.medium.outlined(
                text: 'Custom Border',
                borderColor: Colors.orange,
                foregroundColor: Colors.orange,
                borderRadius: 25,
              ),
              const SizedBox(height: 8),
              FCPButton.medium.iconButton(
                icon: Icons.favorite,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                borderRadius: 50,
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Full Width Buttons', [
              FCPButton.medium.primary(
                text: 'Full Width Button',
                width: double.infinity,
              ),
              const SizedBox(height: 8),
              FCPButton.medium.outlined(
                text: 'Full Width Outlined',
                width: double.infinity,
              ),
            ]),

            const SizedBox(height: 24),
            _buildSection('Custom Padding & Margin', [
              FCPButton.medium.primary(
                text: 'Custom Padding',
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              const SizedBox(height: 8),
              FCPButton.medium.secondary(
                text: 'With Margin',
                margin: const EdgeInsets.all(8),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

/// Usage examples in code comments
class FCPButtonUsageExamples {
  // Basic usage examples:

  // Small primary button
  // FCPButton.small.primary(text: 'Click me')

  // Medium outlined button with icon
  // FCPButton.medium.outlined(
  //   text: 'Download',
  //   icon: Icons.download,
  //   iconPosition: IconPosition.start,
  // )

  // Large icon button
  // FCPButton.large.iconButton(icon: Icons.add)

  // Floating button
  // FCPButton.medium.floating(
  //   text: 'Add Item',
  //   icon: Icons.add,
  // )

  // Elevated button with custom styling
  // FCPButton.large.elevated(
  //   text: 'Submit',
  //   backgroundColor: Colors.green,
  //   borderRadius: 25,
  //   elevation: 6,
  // )

  // Loading state
  // FCPButton.medium.primary(
  //   text: 'Processing...',
  //   isLoading: true,
  // )

  // Disabled state
  // FCPButton.medium.outlined(
  //   text: 'Unavailable',
  //   isDisabled: true,
  // )

  // Full width button
  // FCPButton.medium.contained(
  //   text: 'Sign In',
  //   width: double.infinity,
  // )
}
