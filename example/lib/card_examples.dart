import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Examples of how to use the custom card components
class CardExamples extends StatelessWidget {
  const CardExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Custom Card'),
            _buildBasicCardExample(),

            const SizedBox(height: 24),
            _buildSectionTitle('Shaded Cards'),
            _buildShadedCardExamples(),

            const SizedBox(height: 24),
            _buildSectionTitle('Flat Cards'),
            _buildFlatCardExamples(),

            const SizedBox(height: 24),
            _buildSectionTitle('Info Cards'),
            _buildInfoCardExamples(),

            const SizedBox(height: 24),
            _buildSectionTitle('Gradient Cards'),
            _buildGradientCardExamples(),

            const SizedBox(height: 24),
            _buildSectionTitle('Action Cards'),
            _buildActionCardExamples(),

            // const SizedBox(height: 24),
            // _buildSectionTitle('Advanced Examples'),
            // _buildAdvancedCardExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBasicCardExample() {
    return Column(
      children: [
        FCPCard(child: const Text('Simple custom card with default styling')),
        const SizedBox(height: 12),
        FCPCard(
          backgroundColor: Colors.blue.shade50,
          borderColor: Colors.blue.shade200,
          borderWidth: 2,
          borderRadius: 16,
          elevation: 4,
          shadowColor: Colors.blue.withValues(alpha: 0.3),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Custom styled card with blue theme',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FCPCard(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.pink.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: 20,
          elevation: 8,
          onTap: () {
            // Card tapped action
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Gradient card with tap interaction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShadedCardExamples() {
    return Column(
      children: [
        FCPCard.shaded(
          shadowType: ShadowType.small,
          child: const Text('Small shadow card'),
        ),
        const SizedBox(height: 12),
        FCPCard.shaded(
          shadowType: ShadowType.medium,
          child: const Text('Medium shadow card'),
        ),
        const SizedBox(height: 12),
        FCPCard.shaded(
          shadowType: ShadowType.large,
          child: const Text('Large shadow card'),
        ),
        const SizedBox(height: 12),
        FCPCard.shaded(
          shadowType: ShadowType.soft,
          child: const Text('Soft shadow card'),
        ),
        const SizedBox(height: 12),
        FCPCard.shaded(
          shadowType: ShadowType.hard,
          child: const Text('Hard shadow card'),
        ),
        const SizedBox(height: 12),
        FCPCard.shaded(
          shadowType: ShadowType.extraLarge,
          backgroundColor: Colors.orange.shade50,
          child: const Text('Extra large shadow with custom background'),
        ),
      ],
    );
  }

  Widget _buildFlatCardExamples() {
    return Column(
      children: [
        FCPCard.flat(child: const Text('Simple flat card')),
        const SizedBox(height: 12),
        FCPCard.flat(
          backgroundColor: Colors.green.shade50,
          borderColor: Colors.green.shade300,
          borderWidth: 2,
          borderRadius: 16,
          child: const Text('Flat card with green border'),
        ),
        const SizedBox(height: 12),
        FCPCard.flat(
          backgroundColor: Colors.transparent,
          borderColor: Colors.grey.shade400,
          borderWidth: 1,
          borderRadius: 8,
          onTap: () {
            // Flat card tapped action
          },
          child: const Text('Interactive flat card'),
        ),
      ],
    );
  }

  Widget _buildInfoCardExamples() {
    return Column(
      children: [
        FCPCard.info(
          icon: Icons.info,
          title: 'Information Card',
          subtitle: 'This is a subtitle',
          content: 'This is the main content of the information card.',
        ),
        const SizedBox(height: 12),
        FCPCard.info(
          icon: Icons.warning,
          iconColor: Colors.orange,
          title: 'Warning Card',
          content: 'This is a warning message with custom icon color.',
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        const SizedBox(height: 12),
        FCPCard.info(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: const Icon(Icons.person, color: Colors.blue),
          ),
          title: 'Profile Card',
          subtitle: 'User Information',
          content:
              'This card shows user profile information with a custom leading widget.',
        ),
        const SizedBox(height: 12),
        FCPCard.info(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          title: 'Success Card',
          content: 'Operation completed successfully!',
          backgroundColor: Colors.green.shade50,
          borderColor: Colors.green.shade200,
        ),
      ],
    );
  }

  Widget _buildGradientCardExamples() {
    return Column(
      children: [
        FCPCard.gradient(
          gradientType: GradientType.primary,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Primary Gradient',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FCPCard.gradient(
          gradientType: GradientType.sunset,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Sunset Gradient',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FCPCard.gradient(
          gradientType: GradientType.ocean,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Ocean Gradient',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // const SizedBox(height: 12),
        // FCPCard.gradient(
        //   gradientType: GradientType.radial,
        //   gradientColors: [Colors.purple.shade400, Colors.pink.shade400],
        //   child: const Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       'Custom Radial Gradient',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 12),
        FCPCard.gradient(
          gradientType: GradientType.linear,
          gradientColors: [
            Colors.teal.shade400,
            Colors.cyan.shade400,
            Colors.blue.shade400,
          ],
          gradientStops: [0.0, 0.5, 1.0],
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Multi-color Linear Gradient',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FCPCard.gradient(
          gradientType: GradientType.forest,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Forest Gradient',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // const SizedBox(height: 12),
        // FCPCard.gradient(
        //   gradientType: GradientType.sweep,
        //   gradientColors: [
        //     Colors.pink.shade300,
        //     Colors.purple.shade300,
        //     Colors.blue.shade300,
        //   ],
        //   child: const Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       'Sweep Gradient',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildActionCardExamples() {
    return Column(
      children: [
        FCPCard.action(
          icon: Icons.settings,
          title: 'Settings Card',
          content: 'Configure your application settings.',
          actions: [
            TextButton(
              onPressed: () {
                // Cancel action
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save action
              },
              child: const Text('Save'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FCPCard.action(
          icon: Icons.delete,
          iconColor: Colors.red,
          title: 'Delete Confirmation',
          content: 'Are you sure you want to delete this item?',
          actions: [
            TextButton(
              onPressed: () {
                // Cancel action
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Delete action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
          actionAlignment: MainAxisAlignment.spaceBetween,
        ),
        const SizedBox(height: 12),
        FCPCard.action(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: 'User Profile',
          subtitle: 'John Doe',
          content: 'Manage your profile information and preferences.',
          actions: [
            IconButton(
              onPressed: () {
                // Edit action
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                // Share action
              },
              icon: const Icon(Icons.share),
            ),
            IconButton(
              onPressed: () {
                // More action
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
          actionAlignment: MainAxisAlignment.end,
        ),
        const SizedBox(height: 12),
        FCPCard.action(
          icon: Icons.notifications,
          title: 'Notification Settings',
          content: 'Customize your notification preferences.',
          showDivider: false,
          actions: [
            Switch(
              value: true,
              onChanged: (value) {
                // Switch toggled action
              },
            ),
          ],
          actionAlignment: MainAxisAlignment.end,
        ),
      ],
    );
  }
}
