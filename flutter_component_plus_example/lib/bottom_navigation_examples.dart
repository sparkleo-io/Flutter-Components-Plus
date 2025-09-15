import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Example page demonstrating the FCPBottomNavigationBar component
class BottomNavigationExamples extends StatefulWidget {
  const BottomNavigationExamples({super.key});

  @override
  State<BottomNavigationExamples> createState() =>
      _BottomNavigationExamplesState();
}

class _BottomNavigationExamplesState extends State<BottomNavigationExamples> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomePage(),
    const _SearchPage(),
    const _ProfilePage(),
    const _SettingsPage(),
  ];

  final List<String> _icons = [
    'assets/icons/home.png',
    'assets/icons/search.png',
    'assets/icons/profile.png',
    'assets/icons/settings.png',
  ];

  final List<String> _activeIcons = [
    'assets/icons/home_active.png',
    'assets/icons/search_active.png',
    'assets/icons/profile_active.png',
    'assets/icons/settings_active.png',
  ];

  final List<String> _labels = ['Home', 'Search', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Examples'),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_currentIndex]),
          // Default Bottom Navigation Bar
          FCPBottomNavigationBar(
            currentIndex: _currentIndex,
            onItemChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            widgets: _pages,
            icons: _icons,
            activeIcons: _activeIcons,
            labels: _labels,
          ),
        ],
      ),
    );
  }
}

/// Example page demonstrating custom styled bottom navigation bar
class CustomBottomNavigationExamples extends StatefulWidget {
  const CustomBottomNavigationExamples({super.key});

  @override
  State<CustomBottomNavigationExamples> createState() =>
      _CustomBottomNavigationExamplesState();
}

class _CustomBottomNavigationExamplesState
    extends State<CustomBottomNavigationExamples> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomePage(),
    const _SearchPage(),
    const _ProfilePage(),
    const _SettingsPage(),
  ];

  final List<String> _icons = [
    'assets/icons/home.png',
    'assets/icons/search.png',
    'assets/icons/profile.png',
    'assets/icons/settings.png',
  ];

  final List<String> _activeIcons = [
    'assets/icons/home_active.png',
    'assets/icons/search_active.png',
    'assets/icons/profile_active.png',
    'assets/icons/settings_active.png',
  ];

  final List<String> _labels = ['Home', 'Search', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Bottom Navigation'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_currentIndex]),
          // Custom styled Bottom Navigation Bar
          FCPBottomNavigationBar(
            currentIndex: _currentIndex,
            onItemChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            widgets: _pages,
            icons: _icons,
            activeIcons: _activeIcons,
            labels: _labels,
            backgroundColor: Colors.deepPurple,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.deepPurple.shade200,
            elevation: 12,
          ),
        ],
      ),
    );
  }
}

// Example page widgets
class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 64, color: FCPColorScheme.primary),
          const SizedBox(height: 16),
          Text('Home Page', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'This is the home page content',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: FCPColorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Search Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Search functionality would go here',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: FCPColorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Profile Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'User profile information',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64, color: FCPColorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Settings Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'App settings and preferences',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
