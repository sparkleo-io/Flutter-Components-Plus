import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Comprehensive example showing different BLE scanning configurations
class BLEScanExamples extends StatefulWidget {
  const BLEScanExamples({super.key});

  @override
  State<BLEScanExamples> createState() => _BLEScanExamplesState();
}

class _BLEScanExamplesState extends State<BLEScanExamples> {
  final BLEService _bleService = BLEService();

  bool _isInitialized = false;
  String? _error;
  String _statusMessage = 'Not initialized';

  // Scan configuration
  bool _alwaysScan = false;
  bool _androidUsesFineLocation = true;
  bool _saveScanDevices = false;
  Duration _scanDuration = const Duration(seconds: 10);

  // Device list
  List<BLEDeviceModel> _devices = [];
  StreamSubscription<BLEDeviceModel>? _deviceSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _deviceSubscription?.cancel();
    _bleService.dispose();
    super.dispose();
  }

  /// Initialize BLE with current configuration
  Future<void> _initializeBLE() async {
    try {
      setState(() {
        _error = null;
        _statusMessage = 'Initializing BLE...';
      });

      final success = await _bleService.initializeWithContext(
        context,
        scanDuration: _scanDuration,
        autoConnect: false,
        deviceFilters: [], // No filters for this example
        usePrefs: true,
        debugMode: true,
        alwaysScan: _alwaysScan,
        androidUsesFineLocation: _androidUsesFineLocation,
        saveScanDevices: _saveScanDevices,
        title: 'BLE Scan Configuration',
        message:
            'This example demonstrates different BLE scanning configurations.',
        confirmText: 'Enable',
        cancelText: 'Cancel',
      );

      if (success) {
        setState(() {
          _isInitialized = true;
          _statusMessage = 'BLE Service initialized successfully!';
        });
        _setupStreamSubscriptions();
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

  /// Set up stream subscriptions
  void _setupStreamSubscriptions() {
    _deviceSubscription = _bleService.deviceFoundStream.listen((device) {
      setState(() {
        _devices.add(device);
      });
    });
  }

  /// Start scanning
  Future<void> _startScan() async {
    try {
      if (!_isInitialized) {
        _showSnackBar('Please initialize BLE service first', Colors.orange);
        return;
      }

      _devices.clear();
      await _bleService.startScan();
      _showSnackBar('Scanning started', Colors.blue);
    } catch (e) {
      _showSnackBar('Failed to start scan: $e', Colors.red);
    }
  }

  /// Stop scanning
  Future<void> _stopScan() async {
    try {
      await _bleService.stopScan();
      _showSnackBar('Scanning stopped', Colors.orange);
    } catch (e) {
      _showSnackBar('Failed to stop scan: $e', Colors.red);
    }
  }

  /// Clear devices
  void _clearDevices() {
    setState(() {
      _devices.clear();
    });
    _showSnackBar('Device list cleared', Colors.grey);
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
        title: const Text('BLE Scan Configuration Examples'),
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
                    const SizedBox(height: 8),
                    Text('Initialized: $_isInitialized'),
                    Text('Scanning: ${_bleService.isScanning}'),
                    Text('Discovered Devices: ${_devices.length}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Scan Configuration Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Scan Configuration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Always Scan Toggle
                    SwitchListTile(
                      title: const Text('Always Scan'),
                      subtitle: const Text(
                        'Continuously scan until manually stopped',
                      ),
                      value: _alwaysScan,
                      onChanged: (value) {
                        setState(() {
                          _alwaysScan = value;
                        });
                      },
                    ),

                    // Android Fine Location Toggle
                    SwitchListTile(
                      title: const Text('Android Fine Location'),
                      subtitle: const Text(
                        'Use fine location for Android scanning',
                      ),
                      value: _androidUsesFineLocation,
                      onChanged: (value) {
                        setState(() {
                          _androidUsesFineLocation = value;
                        });
                      },
                    ),

                    // Save Scan Devices Toggle
                    SwitchListTile(
                      title: const Text('Save Scan Devices'),
                      subtitle: const Text(
                        'Save discovered devices to preferences',
                      ),
                      value: _saveScanDevices,
                      onChanged: (value) {
                        setState(() {
                          _saveScanDevices = value;
                        });
                      },
                    ),

                    // Scan Duration
                    const SizedBox(height: 16),
                    const Text('Scan Duration (seconds):'),
                    Slider(
                      value: _scanDuration.inSeconds.toDouble(),
                      min: 5,
                      max: 60,
                      divisions: 11,
                      label: '${_scanDuration.inSeconds}s',
                      onChanged: (value) {
                        setState(() {
                          _scanDuration = Duration(seconds: value.toInt());
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Control Buttons
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BLE Controls',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _isInitialized ? null : _initializeBLE,
                      icon: const Icon(Icons.bluetooth),
                      label: const Text('Initialize BLE'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isInitialized && !_bleService.isScanning
                                ? _startScan
                                : null,
                            icon: const Icon(Icons.search),
                            label: const Text('Start Scan'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isInitialized && _bleService.isScanning
                                ? _stopScan
                                : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Stop Scan'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _devices.isEmpty ? null : _clearDevices,
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear Devices'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Configuration Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Configuration Info',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Always Scan',
                      _alwaysScan ? 'Enabled' : 'Disabled',
                    ),
                    _buildInfoRow(
                      'Android Fine Location',
                      _androidUsesFineLocation ? 'Enabled' : 'Disabled',
                    ),
                    _buildInfoRow(
                      'Save Scan Devices',
                      _saveScanDevices ? 'Enabled' : 'Disabled',
                    ),
                    _buildInfoRow(
                      'Scan Duration',
                      '${_scanDuration.inSeconds} seconds',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Note: Always Scan will continuously scan until manually stopped. '
                      'Save Scan Devices will persist discovered devices to SharedPreferences.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Device List
            if (_devices.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Discovered Devices',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_devices.length} devices',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: _devices.length,
                          itemBuilder: (context, index) {
                            final device = _devices[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: Icon(
                                  Icons.bluetooth,
                                  color: device.isConnected
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                                title: Text(device.name),
                                subtitle: Text(
                                  'ID: ${device.id}\nRSSI: ${device.rssi} dBm',
                                ),
                                trailing: Text(
                                  'Last seen: ${_formatTime(device.lastSeen)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }
}
