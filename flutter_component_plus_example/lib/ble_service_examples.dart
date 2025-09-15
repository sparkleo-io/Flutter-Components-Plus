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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
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
      body: Padding(
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
                      '7. Request All Permissions: Request all necessary permissions for BLE operations',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool isGranted, {bool indent = false}) {
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
          '$label: ${isGranted ? "Granted" : "Not Granted"}',
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
