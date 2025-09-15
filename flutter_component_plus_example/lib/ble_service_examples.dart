import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Example demonstrating the usage of FcpBleService
class BleServiceExamples extends StatefulWidget {
  const BleServiceExamples({super.key});

  @override
  State<BleServiceExamples> createState() => _BleServiceExamplesState();
}

class _BleServiceExamplesState extends State<BleServiceExamples> {
  final FcpBleService _bleService = FcpBleService.instance;
  BlePermissionStatus? _permissionStatus;
  BleScanState? _scanState;
  bool _isLoading = false;
  StreamSubscription<BleScanState>? _scanSubscription;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _setupScanListener();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }

  void _setupScanListener() {
    _scanSubscription = _bleService.scanStateStream.listen((scanState) {
      setState(() {
        _scanState = scanState;
      });
    });
  }

  Future<void> _checkPermissions() async {
    setState(() => _isLoading = true);
    try {
      final status = await _bleService.checkPermissions();
      setState(() {
        _permissionStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error checking permissions: $e');
    }
  }

  Future<void> _turnOnBluetooth() async {
    setState(() => _isLoading = true);
    try {
      final success = await _bleService.turnOnBluetooth();
      if (success) {
        _showSuccessSnackBar('Bluetooth turned on successfully');
        _checkPermissions(); // Refresh status
      } else {
        _showErrorSnackBar('Failed to turn on Bluetooth');
      }
    } catch (e) {
      _showErrorSnackBar('Error turning on Bluetooth: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _turnOnLocation() async {
    setState(() => _isLoading = true);
    try {
      final success = await _bleService.turnOnLocation();
      if (success) {
        _showSuccessSnackBar('Location services and permission enabled');
        _checkPermissions(); // Refresh status
      } else {
        _showErrorSnackBar('Failed to enable location services');
      }
    } catch (e) {
      _showErrorSnackBar('Error enabling location services: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _turnOnLocationService() async {
    setState(() => _isLoading = true);
    try {
      final success = await _bleService.turnOnLocationService();
      if (success) {
        _showSuccessSnackBar('Location services enabled');
        _checkPermissions(); // Refresh status
      } else {
        _showErrorSnackBar('Failed to enable location services');
      }
    } catch (e) {
      _showErrorSnackBar('Error enabling location services: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _requestLocationPermission() async {
    setState(() => _isLoading = true);
    try {
      final success = await _bleService.requestLocationPermission();
      if (success) {
        _showSuccessSnackBar('Location permission granted');
        _checkPermissions(); // Refresh status
      } else {
        _showErrorSnackBar('Failed to grant location permission');
      }
    } catch (e) {
      _showErrorSnackBar('Error requesting location permission: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _turnOnAllServices() async {
    setState(() => _isLoading = true);
    try {
      final status = await _bleService.turnOnAllServices();
      setState(() {
        _permissionStatus = status;
        _isLoading = false;
      });

      if (status.allGranted) {
        _showSuccessSnackBar('All services enabled successfully');
      } else {
        _showErrorSnackBar('Some services could not be enabled');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error enabling services: $e');
    }
  }

  Future<void> _requestPermissions() async {
    setState(() => _isLoading = true);
    try {
      final status = await _bleService.requestPermissions();
      setState(() {
        _permissionStatus = status;
        _isLoading = false;
      });

      if (status.allGranted) {
        _showSuccessSnackBar('All permissions granted');
      } else {
        _showErrorSnackBar('Some permissions were not granted');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error requesting permissions: $e');
    }
  }

  Future<void> _startScan() async {
    setState(() => _isLoading = true);
    try {
      _requestPermissions();
      final config = BleScanConfig(
        scanTimeout: const Duration(seconds: 15),
        alwaysScan: false,
        useFineLocation: true,
        checkPermissionsBeforeScan: true,
        filters: const [], // No filters - show all devices
        debugMode: true,
        filterUnknownDevices: true,
      );

      final result = await _bleService.startScan(config: config);
      if (result.status == BleScanStatus.scanning) {
        _showSuccessSnackBar('BLE scan started successfully');
      } else {
        _showErrorSnackBar('Failed to start scan: ${result.error}');
      }
    } catch (e) {
      _showErrorSnackBar('Error starting scan: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _stopScan() async {
    setState(() => _isLoading = true);
    try {
      final result = await _bleService.stopScan();
      if (result.status == BleScanStatus.stopped) {
        _showSuccessSnackBar('BLE scan stopped successfully');
      } else {
        _showErrorSnackBar('Failed to stop scan: ${result.error}');
      }
    } catch (e) {
      _showErrorSnackBar('Error stopping scan: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _clearScanResults() async {
    _bleService.clearScanResults();
    _showSuccessSnackBar('Scan results cleared');
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Service Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Permission Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Permission Status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (_permissionStatus != null) ...[
                        _buildStatusRow(
                          'Bluetooth',
                          _permissionStatus!.bluetoothOn,
                        ),
                        const SizedBox(height: 8),
                        _buildStatusRow(
                          'Location (Overall)',
                          _permissionStatus!.locationOn,
                        ),
                        if (_permissionStatus!.locationServiceEnabled !=
                            null) ...[
                          const SizedBox(height: 4),
                          _buildStatusRow(
                            '  - Location Service',
                            _permissionStatus!.locationServiceEnabled!,
                            indent: true,
                          ),
                        ],
                        if (_permissionStatus!.locationPermissionGranted !=
                            null) ...[
                          const SizedBox(height: 4),
                          _buildStatusRow(
                            '  - Location Permission',
                            _permissionStatus!.locationPermissionGranted!,
                            indent: true,
                          ),
                        ],
                        const SizedBox(height: 8),
                        _buildStatusRow(
                          'All Permissions',
                          _permissionStatus!.allGranted,
                        ),
                        if (_permissionStatus!.error != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Error: ${_permissionStatus!.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ] else
                        const Text('No status available'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Scan Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Scan Status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_scanState != null) ...[
                        _buildStatusRow(
                          'Scan Status',
                          _scanState!.status == BleScanStatus.scanning,
                          statusText: _scanState!.status.name,
                        ),
                        const SizedBox(height: 8),
                        _buildStatusRow(
                          'Devices Found',
                          _scanState!.devices.isNotEmpty,
                          statusText: '${_scanState!.devices.length} devices',
                        ),
                        if (_scanState!.error != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Error: ${_scanState!.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ] else
                        const Text('No scan data available'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _checkPermissions,
                icon: const Icon(Icons.refresh),
                label: const Text('Check Permissions'),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _turnOnBluetooth,
                icon: const Icon(Icons.bluetooth),
                label: const Text('Turn On Bluetooth'),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _turnOnLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Turn On Location (Service + Permission)'),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _turnOnLocationService,
                icon: const Icon(Icons.location_searching),
                label: const Text('Turn On Location Service Only'),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _requestLocationPermission,
                icon: const Icon(Icons.security),
                label: const Text('Request Location Permission Only'),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _turnOnAllServices,
                icon: const Icon(Icons.settings),
                label: const Text('Turn On All Services'),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _requestPermissions,
                icon: const Icon(Icons.security),
                label: const Text('Request All Permissions'),
              ),
              const SizedBox(height: 20),

              // Scan Buttons
              const Text(
                'BLE Scanning',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _startScan,
                icon: const Icon(Icons.search),
                label: const Text('Start BLE Scan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _stopScan,
                icon: const Icon(Icons.stop),
                label: const Text('Stop BLE Scan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _clearScanResults,
                icon: const Icon(Icons.clear),
                label: const Text('Clear Scan Results'),
              ),
              const SizedBox(height: 20),

              // Scanned Devices List
              if (_scanState != null && _scanState!.devices.isNotEmpty) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Scanned Devices',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: _scanState!.devices.length,
                            itemBuilder: (context, index) {
                              final device = _scanState!.devices[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: const Icon(Icons.bluetooth),
                                  title: Text(device.deviceName),
                                  subtitle: Text('ID: ${device.deviceId}'),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('RSSI: ${device.rssi}'),
                                      Text(
                                        '${device.timestamp.hour}:${device.timestamp.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(fontSize: 12),
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
                const SizedBox(height: 20),
              ],

              // Usage Instructions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Usage Instructions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '1. Check Permissions: Verify current status of Bluetooth and location services\n'
                        '2. Turn On Bluetooth: Attempt to enable Bluetooth on the device\n'
                        '3. Turn On Location (Service + Permission): Enable location services AND request permission\n'
                        '4. Turn On Location Service Only: Enable location services without requesting permission\n'
                        '5. Request Location Permission Only: Request location permission without enabling services\n'
                        '6. Turn On All Services: Enable both Bluetooth and location services\n'
                        '7. Request All Permissions: Request all necessary permissions for BLE operations\n'
                        '8. Start BLE Scan: Scan for nearby BLE devices (15 second timeout)\n'
                        '9. Stop BLE Scan: Stop the current scan operation\n'
                        '10. Clear Scan Results: Clear the list of found devices',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow(
    String label,
    bool isGranted, {
    bool indent = false,
    String? statusText,
  }) {
    return Row(
      children: [
        if (indent) const SizedBox(width: 16),
        Icon(
          isGranted ? Icons.check_circle : Icons.cancel,
          color: isGranted ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ${statusText ?? (isGranted ? "Granted" : "Not Granted")}',
          style: TextStyle(
            color: isGranted ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: indent ? 14 : 16,
          ),
        ),
      ],
    );
  }
}
