import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Examples showing how to use BLEService for programmatic BLE operations
class BLEServiceExamples extends StatefulWidget {
  const BLEServiceExamples({super.key});

  @override
  State<BLEServiceExamples> createState() => _BLEServiceExamplesState();
}

class _BLEServiceExamplesState extends State<BLEServiceExamples> {
  final BLEService _bleService = BLEService();

  // State variables
  bool _isInitialized = false;
  bool _isScanning = false;
  bool _isConnected = false;
  List<BLEDeviceModel> _devices = [];
  List<BLEServiceModel> _services = [];
  String? _error;
  String? _connectionStatus;

  // Configuration
  int _requestedMtu = 23; // Default BLE MTU

  // Stream subscriptions
  StreamSubscription<BLEDeviceModel>? _deviceSubscription;
  StreamSubscription<BLEConnectionState>? _connectionSubscription;
  StreamSubscription<BLEScanState>? _scanSubscription;
  StreamSubscription<List<BLEServiceModel>>? _servicesSubscription;
  StreamSubscription<String>? _errorSubscription;

  @override
  void initState() {
    super.initState();
    _initializeBLE();
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

  /// Initialize BLE service with enhanced configuration
  Future<void> _initializeBLE() async {
    try {
      final success = await _bleService.initializeWithContext(
        context,

        // scanDuration: const Duration(seconds: 15), // Longer scan duration
        autoConnect: false,
        deviceFilters: ["Leo"], // Filter for devices containing "Leo"
        usePrefs: true, // Enable SharedPreferences for device storage
        debugMode: true, // Enable debug logging
        alwaysScan: true, // Set to true for continuous scanning
        androidUsesFineLocation: true, // Use fine location for better accuracy
        saveScanDevices: false, // Automatically save discovered devices
        requestedMtu: _requestedMtu, // MTU size for data transfer
        title: 'BLE Service Setup',
        message:
            'This example demonstrates BLE service with device filtering, automatic saving, and enhanced scanning options.',
        confirmText: 'Enable BLE',
        cancelText: 'Cancel',
      );

      if (success) {
        setState(() {
          _isInitialized = true;
        });
        _setupStreamSubscriptions();
        _showSnackBar('BLE Service initialized successfully', Colors.green);
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize BLE: $e';
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
        _connectionStatus = _getConnectionStateText(state);
      });
      _showSnackBar('Connection state: $_connectionStatus', Colors.orange);
    });

    _scanSubscription = _bleService.scanStateStream.listen((state) {
      setState(() {
        _isScanning = state == BLEScanState.scanning;
      });
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

  /// Get saved devices from preferences
  Future<void> _getSavedDevices() async {
    try {
      final savedDevices = await _bleService.getSavedDevices();
      _showSnackBar('Found ${savedDevices.length} saved devices', Colors.green);

      // Show saved devices in a dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Saved Devices'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: savedDevices.length,
                itemBuilder: (context, index) {
                  final device = savedDevices[index];
                  return ListTile(
                    leading: const Icon(Icons.bluetooth),
                    title: Text(device.name),
                    subtitle: Text(
                      'ID: ${device.id}\nRSSI: ${device.rssi} dBm',
                    ),
                    trailing: Text(
                      'Saved: ${_formatTime(device.lastSeen)}',
                      style: const TextStyle(fontSize: 12),
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

  /// Clear all devices
  void _clearDevices() {
    setState(() {
      _devices.clear();
    });
    _showSnackBar('Device list cleared', Colors.grey);
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
      _showSnackBar('Disconnected', Colors.orange);
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

  /// Get connection state text
  String _getConnectionStateText(BLEConnectionState state) {
    switch (state) {
      case BLEConnectionState.disconnected:
        return 'Disconnected';
      case BLEConnectionState.connecting:
        return 'Connecting';
      case BLEConnectionState.connected:
        return 'Connected';
      case BLEConnectionState.disconnecting:
        return 'Disconnecting';
      case BLEConnectionState.error:
        return 'Error';
    }
  }

  /// Show snackbar
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
        title: const Text('BLE Service Examples'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildControlButtons(),
            const SizedBox(height: 20),
            _buildDevicesList(),
            const SizedBox(height: 20),
            _buildServicesList(),
            const SizedBox(height: 20),
            _buildErrorDisplay(),
          ],
        ),
      ),
    );
  }

  /// Build header
  Widget _buildHeader() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bluetooth, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 12),
                Text(
                  'BLE Service Examples',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'This example demonstrates how to use the BLEService for programmatic BLE operations without UI components. The service handles scanning, connecting, and managing BLE devices with automatic permission handling.',
              style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Filter: Only devices containing "Leo" in their name will be shown',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build status card
  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BLE Service Status',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              children: [
                _buildStatusIndicator('Initialized', _isInitialized),
                const SizedBox(width: 16),
                _buildStatusIndicator('Scanning', _isScanning),
                const SizedBox(width: 16),
                _buildStatusIndicator('Connected', _isConnected),
                const SizedBox(width: 16),
                _buildStatusIndicator(
                  'Reconnect',
                  _bleService.isReconnectEnabled,
                ),
              ],
            ),
            if (_connectionStatus != null) ...[
              const SizedBox(height: 8),
              Text('Connection Status: $_connectionStatus'),
            ],
            if (_bleService.isReconnectEnabled) ...[
              const SizedBox(height: 8),
              Text(
                'Reconnect Attempts: ${_bleService.reconnectAttempts}/${_bleService.maxReconnectAttempts}',
              ),
            ],
            const SizedBox(height: 8),
            Text('Requested MTU: ${_bleService.requestedMtu}'),
            Text('Current MTU: ${_bleService.currentMtu}'),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }

  /// Build status indicator
  Widget _buildStatusIndicator(String label, bool isActive) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  /// Build control buttons
  Widget _buildControlButtons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BLE Controls',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isInitialized && !_isScanning
                        ? _startScan
                        : null,
                    icon: const Icon(Icons.search),
                    label: const Text('Start Scan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isInitialized && _isScanning ? _stopScan : null,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop Scan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isInitialized ? _getSavedDevices : null,
                    icon: const Icon(Icons.save),
                    label: const Text('Saved Devices'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
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
            const SizedBox(height: 8),
            // MTU Controls
            if (_isConnected) ...[
              const Text(
                'MTU Controls',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
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
          ],
        ),
      ),
    );
  }

  /// Build devices list
  Widget _buildDevicesList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discovered Devices (${_devices.length})',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 12),
            if (_devices.isEmpty)
              const Center(
                child: Text(
                  'No devices found. Start scanning to discover devices.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                        color: device.isConnected ? Colors.green : Colors.blue,
                      ),
                      title: Text(device.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${device.id}'),
                          Text('RSSI: ${device.rssi} dBm'),
                          if (device.services.isNotEmpty)
                            Text('Services: ${device.services.length}'),
                        ],
                      ),
                      trailing: device.isConnected
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : ElevatedButton(
                              onPressed: () => _connectToDevice(device),
                              child: const Text('Connect'),
                            ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  /// Build services list
  Widget _buildServicesList() {
    if (_services.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discovered Services (${_services.length})',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return ExpansionTile(
                  title: Text(service.name),
                  subtitle: Text('UUID: ${service.uuid}'),
                  children: service.characteristics.map((characteristic) {
                    return ListTile(
                      title: Text(characteristic.name),
                      subtitle: Text('UUID: ${characteristic.uuid}'),
                      trailing: Text(characteristic.properties.join(', ')),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Build error display
  Widget _buildErrorDisplay() {
    if (_error == null) return const SizedBox.shrink();

    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Text(
                  'Error',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(_error!, style: TextStyle(color: Colors.red.shade700)),
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
