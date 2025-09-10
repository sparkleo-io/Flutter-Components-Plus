import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Comprehensive BLE examples demonstrating all features
class BLEComprehensiveExamples extends StatefulWidget {
  const BLEComprehensiveExamples({super.key});

  @override
  State<BLEComprehensiveExamples> createState() =>
      _BLEComprehensiveExamplesState();
}

class _BLEComprehensiveExamplesState extends State<BLEComprehensiveExamples> {
  final BLEService _bleService = BLEService();

  bool _isInitialized = false;
  String? _error;
  String _statusMessage = 'Not initialized';

  // Configuration
  bool _alwaysScan = false;
  bool _androidUsesFineLocation = true;
  bool _saveScanDevices = true;
  bool _usePrefs = true;
  bool _debugMode = true;
  bool _autoConnect = false;
  int _requestedMtu = 23; // Default BLE MTU
  Duration _scanDuration = const Duration(seconds: 15);
  List<String> _deviceFilters = ["Leo"];

  // State
  List<BLEDeviceModel> _devices = [];
  List<BLEServiceModel> _services = [];
  bool _isScanning = false;
  bool _isConnected = false;
  String? _connectedDeviceName;

  // Stream subscriptions
  StreamSubscription<BLEDeviceModel>? _deviceSubscription;
  StreamSubscription<BLEConnectionState>? _connectionSubscription;
  StreamSubscription<BLEScanState>? _scanSubscription;
  StreamSubscription<List<BLEServiceModel>>? _servicesSubscription;
  StreamSubscription<String>? _errorSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _deviceSubscription?.cancel();
    _connectionSubscription?.cancel();
    _scanSubscription?.cancel();
    _servicesSubscription?.cancel();
    _errorSubscription?.cancel();
    _bleService.dispose();
    super.dispose();
  }

  /// Initialize BLE with comprehensive configuration
  Future<void> _initializeBLE() async {
    try {
      setState(() {
        _error = null;
        _statusMessage = 'Initializing BLE with comprehensive configuration...';
      });

      final success = await _bleService.initializeWithContext(
        context,
        scanDuration: _scanDuration,
        autoConnect: _autoConnect,
        deviceFilters: _deviceFilters,
        usePrefs: _usePrefs,
        debugMode: _debugMode,
        alwaysScan: _alwaysScan,
        androidUsesFineLocation: _androidUsesFineLocation,
        saveScanDevices: _saveScanDevices,
        requestedMtu: _requestedMtu,
        title: 'Comprehensive BLE Setup',
        message:
            'This example demonstrates all BLE features including device filtering, automatic saving, enhanced scanning, and permission handling.',
        confirmText: 'Enable All Features',
        cancelText: 'Cancel',
      );

      if (success) {
        setState(() {
          _isInitialized = true;
          _statusMessage = 'BLE Service initialized with all features!';
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
      _showSnackBar('Device found: ${device.name}', Colors.blue);
    });

    _connectionSubscription = _bleService.connectionStateStream.listen((state) {
      setState(() {
        _isConnected = state == BLEConnectionState.connected;
        if (_isConnected) {
          _connectedDeviceName =
              _bleService.connectedDevice?.platformName ?? 'Unknown';
        } else {
          _connectedDeviceName = null;
        }
      });

      switch (state) {
        case BLEConnectionState.connected:
          _showSnackBar('Connected to device', Colors.green);
          break;
        case BLEConnectionState.disconnected:
          _showSnackBar('Disconnected from device', Colors.orange);
          break;
        case BLEConnectionState.connecting:
          _showSnackBar('Connecting...', Colors.blue);
          break;
        case BLEConnectionState.disconnecting:
          _showSnackBar('Disconnecting...', Colors.orange);
          break;
        case BLEConnectionState.error:
          _showSnackBar('Connection error', Colors.red);
          break;
      }
    });

    _scanSubscription = _bleService.scanStateStream.listen((state) {
      setState(() {
        _isScanning = state == BLEScanState.scanning;
      });

      switch (state) {
        case BLEScanState.scanning:
          _showSnackBar('Scanning started', Colors.blue);
          break;
        case BLEScanState.idle:
          _showSnackBar('Scanning stopped', Colors.orange);
          break;
        case BLEScanState.stopped:
          _showSnackBar('Scanning stopped', Colors.orange);
          break;
        case BLEScanState.error:
          _showSnackBar('Scan error', Colors.red);
          break;
      }
    });

    _servicesSubscription = _bleService.servicesDiscoveredStream.listen((
      services,
    ) {
      setState(() {
        _services = services;
      });
      _showSnackBar('Services discovered: ${services.length}', Colors.purple);
    });

    _errorSubscription = _bleService.errorStream.listen((error) {
      setState(() {
        _error = error;
      });
      _showSnackBar('Error: $error', Colors.red);
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
    } catch (e) {
      _showSnackBar('Failed to start scan: $e', Colors.red);
    }
  }

  /// Stop scanning
  Future<void> _stopScan() async {
    try {
      await _bleService.stopScan();
    } catch (e) {
      _showSnackBar('Failed to stop scan: $e', Colors.red);
    }
  }

  /// Connect to device
  Future<void> _connectToDevice(BLEDeviceModel device) async {
    try {
      await _bleService.connectToDevice(device, reconnect: true);
      _showSnackBar(
        'Connecting to ${device.name} with reconnect enabled',
        Colors.blue,
      );
    } catch (e) {
      _showSnackBar('Failed to connect: $e', Colors.red);
    }
  }

  /// Disconnect from device
  Future<void> _disconnectDevice() async {
    try {
      await _bleService.disconnectDevice();
    } catch (e) {
      _showSnackBar('Failed to disconnect: $e', Colors.red);
    }
  }

  /// Stop reconnect attempts
  void _stopReconnect() {
    try {
      _bleService.stopReconnect();
      _showSnackBar('Reconnect attempts stopped', Colors.orange);
    } catch (e) {
      _showSnackBar('Failed to stop reconnect: $e', Colors.red);
    }
  }

  /// Request MTU size
  Future<void> _requestMtu(int mtuSize) async {
    try {
      final success = await _bleService.requestMtu(mtuSize);
      if (success) {
        _showSnackBar('MTU successfully set to $mtuSize', Colors.green);
        setState(() {}); // Refresh UI to show new MTU
      } else {
        _showSnackBar('Failed to set MTU to $mtuSize', Colors.red);
      }
    } catch (e) {
      _showSnackBar('Failed to request MTU: $e', Colors.red);
    }
  }

  /// Get saved devices
  Future<void> _getSavedDevices() async {
    try {
      final savedDevices = await _bleService.getSavedDevices();
      _showSnackBar('Found ${savedDevices.length} saved devices', Colors.green);

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Saved Devices'),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: ListView.builder(
                itemCount: savedDevices.length,
                itemBuilder: (context, index) {
                  final device = savedDevices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Icon(
                        device.isConnected
                            ? Icons.bluetooth_connected
                            : Icons.bluetooth,
                        color: device.isConnected ? Colors.green : Colors.blue,
                      ),
                      title: Text(device.name),
                      subtitle: Text(
                        'ID: ${device.id}\nRSSI: ${device.rssi} dBm',
                      ),
                      trailing: Text(
                        'Saved: ${_formatTime(device.lastSeen)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      _showSnackBar('Failed to get saved devices: $e', Colors.red);
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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprehensive BLE Examples'),
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
                    Text('Scanning: $_isScanning'),
                    Text('Connected: $_isConnected'),
                    Text(
                      'Reconnect Enabled: ${_bleService.isReconnectEnabled}',
                    ),
                    if (_bleService.isReconnectEnabled)
                      Text(
                        'Reconnect Attempts: ${_bleService.reconnectAttempts}/${_bleService.maxReconnectAttempts}',
                      ),
                    if (_connectedDeviceName != null)
                      Text('Connected to: $_connectedDeviceName'),
                    Text('Discovered Devices: ${_devices.length}'),
                    Text('Discovered Services: ${_services.length}'),
                    Text('Requested MTU: ${_bleService.requestedMtu}'),
                    Text('Current MTU: ${_bleService.currentMtu}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Configuration Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Configuration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Always Scan
                    SwitchListTile(
                      title: const Text('Always Scan'),
                      subtitle: const Text(
                        'Continuously scan until manually stopped',
                      ),
                      value: _alwaysScan,
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _alwaysScan = value;
                              });
                            },
                    ),

                    // Android Fine Location
                    SwitchListTile(
                      title: const Text('Android Fine Location'),
                      subtitle: const Text(
                        'Use fine location for better accuracy',
                      ),
                      value: _androidUsesFineLocation,
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _androidUsesFineLocation = value;
                              });
                            },
                    ),

                    // Save Scan Devices
                    SwitchListTile(
                      title: const Text('Save Scan Devices'),
                      subtitle: const Text(
                        'Automatically save discovered devices',
                      ),
                      value: _saveScanDevices,
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _saveScanDevices = value;
                              });
                            },
                    ),

                    // Use Preferences
                    SwitchListTile(
                      title: const Text('Use Preferences'),
                      subtitle: const Text(
                        'Enable SharedPreferences for device storage',
                      ),
                      value: _usePrefs,
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _usePrefs = value;
                              });
                            },
                    ),

                    // Debug Mode
                    SwitchListTile(
                      title: const Text('Debug Mode'),
                      subtitle: const Text('Enable debug logging'),
                      value: _debugMode,
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _debugMode = value;
                              });
                            },
                    ),

                    // Auto Connect
                    SwitchListTile(
                      title: const Text('Auto Connect'),
                      subtitle: const Text(
                        'Automatically connect to filtered devices',
                      ),
                      value: _autoConnect,
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _autoConnect = value;
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
                      onChanged: _isInitialized
                          ? null
                          : (value) {
                              setState(() {
                                _scanDuration = Duration(
                                  seconds: value.toInt(),
                                );
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
                            onPressed: _isInitialized && !_isScanning
                                ? _startScan
                                : null,
                            icon: const Icon(Icons.search),
                            label: const Text('Start Scan'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isInitialized && _isScanning
                                ? _stopScan
                                : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Stop Scan'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isConnected ? _disconnectDevice : null,
                            icon: const Icon(Icons.bluetooth_disabled),
                            label: const Text('Disconnect'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isInitialized ? _getSavedDevices : null,
                            icon: const Icon(Icons.save),
                            label: const Text('Saved Devices'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _devices.isEmpty ? null : _clearDevices,
                            icon: const Icon(Icons.clear),
                            label: const Text('Clear Devices'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _bleService.isReconnectEnabled
                                ? _stopReconnect
                                : null,
                            icon: const Icon(Icons.stop_circle),
                            label: const Text('Stop Reconnect'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // MTU Controls
            if (_isConnected) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MTU Controls',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _requestMtu(23),
                              icon: const Icon(Icons.settings),
                              label: const Text('MTU 23'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _requestMtu(185),
                              icon: const Icon(Icons.settings),
                              label: const Text('MTU 185'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _requestMtu(512),
                              icon: const Icon(Icons.settings),
                              label: const Text('MTU 512'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

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
                                  device.isConnected
                                      ? Icons.bluetooth_connected
                                      : Icons.bluetooth,
                                  color: device.isConnected
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                                title: Text(device.name),
                                subtitle: Text(
                                  'ID: ${device.id}\nRSSI: ${device.rssi} dBm',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Last seen: ${_formatTime(device.lastSeen)}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: device.isConnected
                                          ? null
                                          : () => _connectToDevice(device),
                                      child: Text(
                                        device.isConnected
                                            ? 'Connected'
                                            : 'Connect',
                                      ),
                                    ),
                                  ],
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

            const SizedBox(height: 16),

            // Services List
            if (_services.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Discovered Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: _services.length,
                          itemBuilder: (context, index) {
                            final service = _services[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: const Icon(Icons.settings),
                                title: Text(service.uuid),
                                subtitle: Text(
                                  'Characteristics: ${service.characteristics.length}',
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

  /// Format time for display
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
