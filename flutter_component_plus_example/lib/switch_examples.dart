import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Examples demonstrating the simplified switch components
class SwitchExamplesPage extends StatefulWidget {
  const SwitchExamplesPage({Key? key}) : super(key: key);

  @override
  State<SwitchExamplesPage> createState() => _SwitchExamplesPageState();
}

class _SwitchExamplesPageState extends State<SwitchExamplesPage> {
  // FCPSwitch states
  bool _basicSwitchValue = false;
  bool _iosSwitchValue = false;
  bool _materialSwitchValue = false;
  bool _compactSwitchValue = false;
  bool _largeSwitchValue = false;
  bool _successSwitchValue = false;
  bool _warningSwitchValue = false;
  bool _errorSwitchValue = false;
  bool _customSwitchValue = false;

  // ToggleSwitch states
  bool? _onOffValue;
  String? _intensityValue;
  String? _sizeValue;
  String? _themeValue;
  String? _languageValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFCPSwitchExamples(),
            const SizedBox(height: 32),
            _buildToggleSwitchExamples(),
            const SizedBox(height: 32),
            _buildAdvancedExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildFCPSwitchExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FCP Switch Examples',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          'Basic Switches',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            Column(
              children: [
                FCPSwitch(
                  value: _basicSwitchValue,
                  onChanged: (value) =>
                      setState(() => _basicSwitchValue = value),
                ),
                const SizedBox(height: 8),
                const Text('Default'),
              ],
            ),
            Column(
              children: [
                FCPSwitch(
                  value: _iosSwitchValue,
                  onChanged: (value) => setState(() => _iosSwitchValue = value),
                  width: 51.0,
                  height: 31.0,
                  borderRadius: 15.5,
                  activeColor: const Color(0xFF34C759),
                  inactiveColor: const Color(0xFFE5E5E5),
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  borderColor: const Color(0xFFD4D4D4),
                  thumbSize: 27.0,
                  thumbPadding: 2.0,
                ),
                const SizedBox(height: 8),
                const Text('iOS Style'),
              ],
            ),
            Column(
              children: [
                FCPSwitch(
                  value: _materialSwitchValue,
                  onChanged: (value) =>
                      setState(() => _materialSwitchValue = value),
                  width: 48.0,
                  height: 28.0,
                  borderRadius: 14.0,
                  activeColor: const Color(0xFF007AFF),
                  inactiveColor: const Color(0xFFE5E5E5),
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: const Color(0xFF007AFF),
                  showBorder: false,
                ),
                const SizedBox(height: 8),
                const Text('Material Style'),
              ],
            ),
            Column(
              children: [
                FCPSwitch(
                  value: _compactSwitchValue,
                  onChanged: (value) =>
                      setState(() => _compactSwitchValue = value),
                  width: 40.0,
                  height: 20.0,
                  borderRadius: 10.0,
                  thumbSize: 16.0,
                  thumbPadding: 2.0,
                ),
                const SizedBox(height: 8),
                const Text('Compact'),
              ],
            ),
            Column(
              children: [
                FCPSwitch(
                  value: _largeSwitchValue,
                  onChanged: (value) =>
                      setState(() => _largeSwitchValue = value),
                  width: 70.0,
                  height: 36.0,
                  borderRadius: 18.0,
                  thumbSize: 28.0,
                  thumbPadding: 4.0,
                ),
                const SizedBox(height: 8),
                const Text('Large'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Themed Switches',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            Column(
              children: [
                FCPSwitch(
                  value: _successSwitchValue,
                  onChanged: (value) =>
                      setState(() => _successSwitchValue = value),
                  activeColor: const Color(0xFF34C759),
                  inactiveThumbColor: const Color(0xFF34C759),
                ),
                const SizedBox(height: 8),
                const Text('Success'),
              ],
            ),
            Column(
              children: [
                FCPSwitch(
                  value: _warningSwitchValue,
                  onChanged: (value) =>
                      setState(() => _warningSwitchValue = value),
                  activeColor: const Color(0xFFFF9500),
                  inactiveThumbColor: const Color(0xFFFF9500),
                ),
                const SizedBox(height: 8),
                const Text('Warning'),
              ],
            ),
            Column(
              children: [
                FCPSwitch(
                  value: _errorSwitchValue,
                  onChanged: (value) =>
                      setState(() => _errorSwitchValue = value),
                  activeColor: const Color(0xFFFF3B30),
                  inactiveThumbColor: const Color(0xFFFF3B30),
                ),
                const SizedBox(height: 8),
                const Text('Error'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleSwitchExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Toggle Switch Examples',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          'Two-State Toggle (On/Off)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FCPToggleSwitch<bool>(
          title: 'Power Control',
          states: const [
            ToggleState<bool>(
              value: false,
              label: 'Off',
              icon: Icons.toggle_off,
            ),
            ToggleState<bool>(value: true, label: 'On', icon: Icons.toggle_on),
          ],
          activeValue: _onOffValue,
          onChanged: (value) => setState(() => _onOffValue = value),
          width: 70.0,
          height: 36.0,
          borderRadius: 18.0,
        ),
        const SizedBox(height: 24),
        const Text(
          'Three-State Toggle (Low/Medium/High)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FCPToggleSwitch<String>(
          title: 'Signal Intensity',
          states: const [
            ToggleState<String>(
              value: 'low',
              label: 'Low',
              icon: Icons.signal_cellular_alt_1_bar,
            ),
            ToggleState<String>(
              value: 'medium',
              label: 'Medium',
              icon: Icons.signal_cellular_alt_2_bar,
            ),
            ToggleState<String>(
              value: 'high',
              label: 'High',
              icon: Icons.signal_cellular_alt,
            ),
          ],
          activeValue: _intensityValue,
          onChanged: (value) => setState(() => _intensityValue = value),
        ),
        const SizedBox(height: 24),
        const Text(
          'Size Selection (Labels Only)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FCPToggleSwitch<String>(
          title: 'Size Selection',
          states: const [
            ToggleState<String>(
              value: 'small',
              label: 'S',
              description: 'Small',
            ),
            ToggleState<String>(
              value: 'medium',
              label: 'M',
              description: 'Medium',
            ),
            ToggleState<String>(
              value: 'large',
              label: 'L',
              description: 'Large',
            ),
          ],
          activeValue: _sizeValue,
          onChanged: (value) => setState(() => _sizeValue = value),
          showIcons: false,
          width: 40.0,
          height: 20.0,
          borderRadius: 10.0,
        ),
        const SizedBox(height: 24),
        const Text(
          'Theme Selection (Icons Only)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FCPToggleSwitch<String>(
          title: 'Theme Selection',
          states: const [
            ToggleState<String>(
              value: 'light',
              label: 'Light',
              icon: Icons.light_mode,
            ),
            ToggleState<String>(
              value: 'dark',
              label: 'Dark',
              icon: Icons.dark_mode,
            ),
          ],
          activeValue: _themeValue,
          onChanged: (value) => setState(() => _themeValue = value),
          height: 80,
          showLabels: false,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildAdvancedExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advanced Examples',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          'Custom Switch with Shadow',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FCPSwitch(
          value: _customSwitchValue,
          onChanged: (value) => setState(() => _customSwitchValue = value),
          width: 60,
          height: 32,
          activeColor: const Color(0xFF34C759),
          inactiveColor: const Color(0xFFE5E5E5),
          activeThumbColor: Colors.white,
          inactiveThumbColor: const Color(0xFF34C759),
          showShadow: true,
          shadowBlurRadius: 6,
          shadowOffset: const Offset(0, 3),
        ),
        const SizedBox(height: 24),
        const Text(
          'Custom Toggle with Different Colors',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FCPToggleSwitch<String>(
          title: 'Custom Theme',
          states: const [
            ToggleState<String>(value: 'red', label: 'Red'),
            ToggleState<String>(value: 'green', label: 'Green'),
            ToggleState<String>(value: 'blue', label: 'Blue'),
          ],
          activeValue: _themeValue,
          onChanged: (value) => setState(() => _themeValue = value),
          activeColor: const Color(0xFF9C27B0),
          inactiveColor: const Color(0xFFF3E5F5),
          activeTextColor: Colors.white,
          inactiveTextColor: const Color(0xFF9C27B0),
          borderColor: const Color(0xFF9C27B0),
          showShadow: true,
        ),
      ],
    );
  }
}
