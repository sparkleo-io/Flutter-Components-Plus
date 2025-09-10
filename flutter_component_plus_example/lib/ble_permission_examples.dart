import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Comprehensive example showing BLE permission handling with dialogs
class BLEPermissionExamples extends StatefulWidget {
  const BLEPermissionExamples({super.key});

  @override
  State<BLEPermissionExamples> createState() => _BLEPermissionExamplesState();
}

class _BLEPermissionExamplesState extends State<BLEPermissionExamples> {
  final BLEService _bleService = BLEService();

  bool _isInitialized = false;
  String? _error;
  String _statusMessage = 'Not initialized';

  // Permission status
  bool _bluetoothEnabled = false;
  bool _locationEnabled = false;
  bool _bluetoothPermissionGranted = false;
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  @override
  void dispose() {
    _bleService.dispose();
    super.dispose();
  }

  /// Check current permission and service status
  Future<void> _checkPermissionStatus() async {
    setState(() {
      _bluetoothEnabled = false;
      _locationEnabled = false;
      _bluetoothPermissionGranted = false;
      _locationPermissionGranted = false;
    });

    try {
      final bluetoothEnabled = await BLEPermissionHandler.isBluetoothEnabled();
      final locationEnabled = await BLEPermissionHandler.isLocationEnabled();
      final bluetoothPermissionGranted =
          await BLEPermissionHandler.isBluetoothPermissionGranted();
      final locationPermissionGranted =
          await BLEPermissionHandler.isLocationPermissionGranted();

      setState(() {
        _bluetoothEnabled = bluetoothEnabled;
        _locationEnabled = locationEnabled;
        _bluetoothPermissionGranted = bluetoothPermissionGranted;
        _locationPermissionGranted = locationPermissionGranted;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to check permission status: $e';
      });
    }
  }

  /// Initialize BLE with comprehensive permission handling
  Future<void> _initializeWithFullPermissionHandling() async {
    try {
      setState(() {
        _error = null;
        _statusMessage = 'Initializing BLE with permission dialogs...';
      });

      final success = await _bleService.initializeWithContext(
        context,
        scanDuration: const Duration(seconds: 10),
        autoConnect: false,
        deviceFilters: ["Leo"],
        usePrefs: true,
        debugMode: true,
        alwaysScan: false, // Set to true for continuous scanning
        androidUsesFineLocation: true, // Use fine location for better accuracy
        saveScanDevices: true, // Automatically save discovered devices
        title: 'BLE Setup Required',
        message:
            'This app needs Bluetooth and Location access to scan for BLE devices. We\'ll help you enable them.',
        confirmText: 'Enable',
        cancelText: 'Cancel',
      );

      if (success) {
        setState(() {
          _isInitialized = true;
          _statusMessage = 'BLE Service initialized successfully!';
        });
        _checkPermissionStatus();
        _showSnackBar('BLE Service initialized successfully', Colors.green);
      } else {
        setState(() {
          _error = 'Failed to initialize BLE service';
          _statusMessage = 'Initialization failed';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize BLE: $e';
        _statusMessage = 'Error during initialization';
      });
      _showSnackBar('Failed to initialize BLE: $e', Colors.red);
    }
  }

  /// Initialize BLE without dialogs (programmatic)
  Future<void> _initializeWithoutDialogs() async {
    try {
      setState(() {
        _error = null;
        _statusMessage = 'Initializing BLE without dialogs...';
      });

      final success = await _bleService.initialize(
        scanDuration: const Duration(seconds: 10),
        autoConnect: false,
        deviceFilters: ["Leo"],
        usePrefs: true,
        debugMode: true,
        alwaysScan: false, // Set to true for continuous scanning
        androidUsesFineLocation: true, // Use fine location for better accuracy
        saveScanDevices: true, // Automatically save discovered devices
      );

      if (success) {
        setState(() {
          _isInitialized = true;
          _statusMessage = 'BLE Service initialized successfully!';
        });
        _checkPermissionStatus();
        _showSnackBar('BLE Service initialized successfully', Colors.green);
      } else {
        setState(() {
          _error = 'Failed to initialize BLE service';
          _statusMessage = 'Initialization failed';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize BLE: $e';
        _statusMessage = 'Error during initialization';
      });
      _showSnackBar('Failed to initialize BLE: $e', Colors.red);
    }
  }

  /// Turn on Bluetooth programmatically
  Future<void> _turnOnBluetooth() async {
    try {
      setState(() {
        _statusMessage = 'Turning on Bluetooth...';
      });

      final success = await BLEPermissionHandler.turnOnBluetooth();

      if (success) {
        setState(() {
          _statusMessage = 'Bluetooth turned on successfully!';
        });
        _checkPermissionStatus();
        _showSnackBar('Bluetooth turned on successfully', Colors.green);
      } else {
        setState(() {
          _error = 'Failed to turn on Bluetooth';
          _statusMessage = 'Failed to turn on Bluetooth';
        });
        _showSnackBar('Failed to turn on Bluetooth', Colors.red);
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to turn on Bluetooth: $e';
        _statusMessage = 'Error turning on Bluetooth';
      });
      _showSnackBar('Failed to turn on Bluetooth: $e', Colors.red);
    }
  }

  /// Show Bluetooth enable dialog
  Future<void> _showBluetoothDialog() async {
    final confirmed = await BLEPermissionHandler.showBluetoothEnableDialog(
      context,
      title: 'Bluetooth Required',
      message:
          'Bluetooth is required to scan for BLE devices. Would you like to turn on Bluetooth?',
      confirmText: 'Turn On',
      cancelText: 'Cancel',
    );

    if (confirmed) {
      await _turnOnBluetooth();
    }
  }

  /// Show Location enable dialog
  Future<void> _showLocationDialog() async {
    final confirmed = await BLEPermissionHandler.showLocationEnableDialog(
      context,
      title: 'Location Required',
      message:
          'Location services are required to scan for BLE devices. Would you like to enable Location services?',
      confirmText: 'Enable',
      cancelText: 'Cancel',
    );

    if (confirmed) {
      try {
        final success = await BLEPermissionHandler.openLocationSettings();
        if (success) {
          _showSnackBar('Location settings opened', Colors.green);
        } else {
          _showSnackBar('Failed to open location settings', Colors.red);
        }
      } catch (e) {
        _showSnackBar('Error opening location settings: $e', Colors.red);
      }
    }
  }

  /// Show comprehensive permission dialog
  Future<void> _showComprehensivePermissionDialog() async {
    final success = await BLEPermissionHandler.ensureBLERequirements(
      context,
      title: 'BLE Setup Required',
      message:
          'This app needs Bluetooth and Location access to scan for BLE devices.',
      confirmText: 'Enable All',
      cancelText: 'Cancel',
    );

    if (success) {
      _showSnackBar('All BLE requirements met!', Colors.green);
      _checkPermissionStatus();
    } else {
      _showSnackBar('BLE setup cancelled or failed', Colors.orange);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Permission Examples'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BLE Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Status: $_statusMessage'),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Permission Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Permission & Service Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStatusRow('Bluetooth Enabled', _bluetoothEnabled),
                    _buildStatusRow('Location Enabled', _locationEnabled),
                    _buildStatusRow(
                      'Bluetooth Permission',
                      _bluetoothPermissionGranted,
                    ),
                    _buildStatusRow(
                      'Location Permission',
                      _locationPermissionGranted,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _checkPermissionStatus,
                      child: const Text('Refresh Status'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Initialization Buttons
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BLE Initialization',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _isInitialized
                          ? null
                          : _initializeWithFullPermissionHandling,
                      icon: const Icon(Icons.bluetooth),
                      label: const Text('Initialize with Permission Dialogs'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _isInitialized
                          ? null
                          : _initializeWithoutDialogs,
                      icon: const Icon(Icons.code),
                      label: const Text('Initialize without Dialogs'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Individual Service Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Individual Service Controls',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _bluetoothEnabled ? null : _turnOnBluetooth,
                      icon: const Icon(Icons.bluetooth),
                      label: const Text('Turn On Bluetooth'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _showBluetoothDialog,
                      icon: const Icon(Icons.bluetooth_searching),
                      label: const Text('Show Bluetooth Dialog'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _showLocationDialog,
                      icon: const Icon(Icons.location_on),
                      label: const Text('Show Location Dialog'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Comprehensive Permission Dialog
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Comprehensive Permission Handling',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _showComprehensivePermissionDialog,
                      icon: const Icon(Icons.security),
                      label: const Text('Ensure All BLE Requirements'),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This will check and enable Bluetooth, Location, and request all required permissions with user-friendly dialogs.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // BLE Service Status
            if (_isInitialized) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BLE Service Status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Initialized: ${_bleService.isInitialized}'),
                      Text(
                        'Permissions Granted: ${_bleService.permissionsGranted}',
                      ),
                      Text('Connected: ${_bleService.isConnected}'),
                      Text('Scanning: ${_bleService.isScanning}'),
                      Text(
                        'Discovered Devices: ${_bleService.discoveredDevices.length}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            status ? Icons.check_circle : Icons.cancel,
            color: status ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(
            status ? 'Enabled' : 'Disabled',
            style: TextStyle(
              color: status ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
