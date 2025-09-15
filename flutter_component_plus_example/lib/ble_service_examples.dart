import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
  BleConnectionState? _connectionState;
  ConnectedDeviceInfo? _savedDevice;
  List<ConnectedDeviceInfo> _allStoredDevices = [];
  BleDiscoveryResult? _discoveryResult;
  bool _isLoading = false;
  StreamSubscription<BleScanState>? _scanSubscription;
  StreamSubscription<BleConnectionState>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _setupScanListener();
    _setupConnectionListener();
    _loadSavedDevice();
    _loadAllStoredDevices();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    super.dispose();
  }

  void _setupScanListener() {
    _scanSubscription = _bleService.scanStateStream.listen((scanState) {
      setState(() {
        _scanState = scanState;
      });
    });
  }

  void _setupConnectionListener() {
    _connectionSubscription = _bleService.connectionStateStream.listen((
      connectionState,
    ) {
      setState(() {
        _connectionState = connectionState;
      });
    });
  }

  Future<void> _loadSavedDevice() async {
    try {
      final savedDevice = await _bleService.getConnectedDevice(
        'ble_connected_device',
      );
      setState(() {
        _savedDevice = savedDevice;
      });
    } catch (e) {
      print('Failed to load saved device: $e');
    }
  }

  Future<void> _loadAllStoredDevices() async {
    try {
      final storedDevices = await _bleService.getAllStoredDevices();
      setState(() {
        _allStoredDevices = storedDevices;
      });
    } catch (e) {
      print('Failed to load stored devices: $e');
    }
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
        filters: const ["Leo"], // No filters - show all devices
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

  Future<void> _connectToDevice(BluetoothDevice device) async {
    setState(() => _isLoading = true);
    try {
      final config = BleConnectionConfig(
        timeout: const Duration(seconds: 35),
        mtu: 512,
        autoConnect: false,
        saveDeviceOnConnect: true,
        removeDeviceOnDisconnect: true,
      );

      final result = await _bleService.connectToDevice(
        device,
        config: config,
        storageKey: 'ble_connected_device',
      );

      if (result.status == BleConnectionStatus.connected) {
        _showSuccessSnackBar('Connected to ${device.platformName}');
        _loadSavedDevice(); // Reload saved device info
      } else if (result.status == BleConnectionStatus.connecting) {
        _showSuccessSnackBar('Connecting to ${device.platformName}...');
      } else {
        _showErrorSnackBar('Failed to connect: ${result.error}');
      }
    } catch (e) {
      _showErrorSnackBar('Error connecting to device: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _disconnectFromDevice() async {
    if (_connectionState?.device == null) return;

    setState(() => _isLoading = true);
    try {
      final result = await _bleService.disconnectFromDevice(
        _connectionState!.device,
      );

      if (result.status == BleConnectionStatus.disconnected) {
        _showSuccessSnackBar('Disconnected from device');
        _loadSavedDevice(); // Reload saved device info
        _loadAllStoredDevices(); // Reload all stored devices
      } else {
        _showErrorSnackBar('Failed to disconnect: ${result.error}');
      }
    } catch (e) {
      _showErrorSnackBar('Error disconnecting from device: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _removeSavedDevice() async {
    setState(() => _isLoading = true);
    try {
      final success = await _bleService.removeConnectedDevice(
        'ble_connected_device',
      );
      if (success) {
        setState(() {
          _savedDevice = null;
        });
        _loadAllStoredDevices(); // Reload all stored devices
        _showSuccessSnackBar('Saved device removed');
      } else {
        _showErrorSnackBar('Failed to remove saved device');
      }
    } catch (e) {
      _showErrorSnackBar('Error removing saved device: $e');
    } finally {
      setState(() => _isLoading = false);
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

  void _showStoredDevicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Stored Devices'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: _allStoredDevices.isEmpty
              ? const Center(child: Text('No stored devices found'))
              : ListView.builder(
                  itemCount: _allStoredDevices.length,
                  itemBuilder: (context, index) {
                    final device = _allStoredDevices[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.bluetooth),
                        title: Text(device.deviceName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${device.deviceId}'),
                            Text(
                              'Connected: ${device.connectedAt.day}/${device.connectedAt.month}/${device.connectedAt.year} ${device.connectedAt.hour}:${device.connectedAt.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            if (device.mtu != null)
                              Text(
                                'MTU: ${device.mtu}',
                                style: const TextStyle(fontSize: 12),
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            // Remove this specific device
                            final success = await _bleService
                                .removeConnectedDevice(
                                  'ble_connected_device_${device.deviceId}',
                                );
                            if (success) {
                              _loadAllStoredDevices();
                              _loadSavedDevice();
                              _showSuccessSnackBar('Device removed');
                            } else {
                              _showErrorSnackBar('Failed to remove device');
                            }
                          },
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

  Future<void> _discoverServices() async {
    if (_connectionState?.device == null) {
      _showErrorSnackBar('No device connected');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await _bleService.discoverServices(
        _connectionState!.device,
      );
      setState(() {
        _discoveryResult = result;
      });

      if (result.error != null) {
        _showErrorSnackBar('Discovery failed: ${result.error}');
      } else {
        _showSuccessSnackBar('Found ${result.services.length} services');
      }
    } catch (e) {
      _showErrorSnackBar('Error discovering services: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showServicesDialog() {
    if (_discoveryResult == null) {
      _showErrorSnackBar(
        'No discovery data available. Discover services first.',
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Device Services & Characteristics'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: _discoveryResult!.services.isEmpty
              ? const Center(child: Text('No services found'))
              : ListView.builder(
                  itemCount: _discoveryResult!.services.length,
                  itemBuilder: (context, serviceIndex) {
                    final service = _discoveryResult!.services[serviceIndex];
                    return ExpansionTile(
                      title: Text(
                        'Service: ${service.uuid}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Primary: ${service.isPrimary ? 'Yes' : 'No'} | Characteristics: ${service.characteristics.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      children: service.characteristics.map((characteristic) {
                        return ListTile(
                          title: Text(
                            'Characteristic: ${characteristic.uuid}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Properties: ${_getPropertyNames(characteristic.properties)}',
                                style: const TextStyle(fontSize: 11),
                              ),
                              Text(
                                'Descriptors: ${characteristic.descriptors.length}',
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (characteristic.canRead)
                                const Icon(
                                  Icons.visibility,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                              if (characteristic.canWrite)
                                const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.green,
                                ),
                              if (characteristic.canNotify)
                                const Icon(
                                  Icons.notifications,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        );
                      }).toList(),
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

  // void _showFindServiceDialog() {
  //   final serviceController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Find Service by UUID'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: serviceController,
  //             decoration: const InputDecoration(
  //               labelText: 'Service UUID',
  //               hintText: 'e.g., 0000180F-0000-1000-8000-00805F9B34FB',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () async {
  //             if (serviceController.text.isNotEmpty) {
  //               Navigator.of(context).pop();
  //               await _findService(serviceController.text);
  //             }
  //           },
  //           child: const Text('Find'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void _showFindCharacteristicDialog() {
  //   final serviceController = TextEditingController();
  //   final characteristicController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Find Characteristic by UUID'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: serviceController,
  //             decoration: const InputDecoration(
  //               labelText: 'Service UUID',
  //               hintText: 'e.g., 0000180F-0000-1000-8000-00805F9B34FB',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           TextField(
  //             controller: characteristicController,
  //             decoration: const InputDecoration(
  //               labelText: 'Characteristic UUID',
  //               hintText: 'e.g., 00002A19-0000-1000-8000-00805F9B34FB',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () async {
  //             if (serviceController.text.isNotEmpty &&
  //                 characteristicController.text.isNotEmpty) {
  //               Navigator.of(context).pop();
  //               await _findCharacteristic(
  //                 serviceController.text,
  //                 characteristicController.text,
  //               );
  //             }
  //           },
  //           child: const Text('Find'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _findService(String serviceUuid) async {
    if (_connectionState?.device == null) {
      _showErrorSnackBar('No device connected');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final service = await _bleService.findService(
        _connectionState!.device,
        serviceUuid,
      );

      if (service != null) {
        _showSuccessSnackBar('Service found: ${service.uuid}');
        _showServiceDetailsDialog(service);
      } else {
        _showErrorSnackBar('Service not found: $serviceUuid');
      }
    } catch (e) {
      _showErrorSnackBar('Error finding service: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _findCharacteristic(
    String serviceUuid,
    String characteristicUuid,
  ) async {
    if (_connectionState?.device == null) {
      _showErrorSnackBar('No device connected');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final characteristic = await _bleService.findCharacteristic(
        _connectionState!.device,
        serviceUuid,
        characteristicUuid,
      );

      if (characteristic != null) {
        _showSuccessSnackBar('Characteristic found: ${characteristic.uuid}');
        _showCharacteristicDetailsDialog(characteristic);
      } else {
        _showErrorSnackBar('Characteristic not found: $characteristicUuid');
      }
    } catch (e) {
      _showErrorSnackBar('Error finding characteristic: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showServiceDetailsDialog(BleServiceInfo service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Service Details'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UUID: ${service.uuid}'),
              Text('Primary: ${service.isPrimary ? 'Yes' : 'No'}'),
              Text('Characteristics: ${service.characteristics.length}'),
              const SizedBox(height: 16),
              const Text(
                'Characteristics:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: service.characteristics.length,
                  itemBuilder: (context, index) {
                    final characteristic = service.characteristics[index];
                    return ListTile(
                      title: Text(
                        characteristic.uuid,
                        style: const TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        'Properties: ${_getPropertyNames(characteristic.properties)}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    );
                  },
                ),
              ),
            ],
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

  void _showCharacteristicDetailsDialog(BleCharacteristicInfo characteristic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Characteristic Details'),
        content: SizedBox(
          width: double.maxFinite,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UUID: ${characteristic.uuid}'),
              const SizedBox(height: 8),
              Text(
                'Properties: ${_getPropertyNames(characteristic.properties)}',
              ),
              const SizedBox(height: 8),
              Text('Descriptors: ${characteristic.descriptors.length}'),
              const SizedBox(height: 16),
              const Text(
                'Capabilities:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• Read: ${characteristic.canRead ? 'Yes' : 'No'}'),
              Text('• Write: ${characteristic.canWrite ? 'Yes' : 'No'}'),
              Text(
                '• Write Without Response: ${characteristic.canWriteWithoutResponse ? 'Yes' : 'No'}',
              ),
              Text('• Notify: ${characteristic.canNotify ? 'Yes' : 'No'}'),
              Text('• Indicate: ${characteristic.canIndicate ? 'Yes' : 'No'}'),
            ],
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

  String _getPropertyNames(CharacteristicProperties properties) {
    final propertyNames = <String>[];
    if (properties.read) propertyNames.add('read');
    if (properties.write) propertyNames.add('write');
    if (properties.writeWithoutResponse)
      propertyNames.add('writeWithoutResponse');
    if (properties.notify) propertyNames.add('notify');
    if (properties.indicate) propertyNames.add('indicate');
    if (properties.broadcast) propertyNames.add('broadcast');
    if (properties.authenticatedSignedWrites)
      propertyNames.add('authenticatedSignedWrites');
    if (properties.extendedProperties) propertyNames.add('extendedProperties');
    return propertyNames.join(', ');
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

              // Connection Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Connection Status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_connectionState != null) ...[
                        _buildStatusRow(
                          'Connection Status',
                          _connectionState!.status ==
                              BleConnectionStatus.connected,
                          statusText: _connectionState!.status.name,
                        ),
                        const SizedBox(height: 8),
                        _buildStatusRow(
                          'Device',
                          true,
                          statusText:
                              _connectionState!.device.platformName.isNotEmpty
                              ? _connectionState!.device.platformName
                              : 'Unknown Device',
                        ),
                        if (_connectionState!.mtu != null) ...[
                          const SizedBox(height: 8),
                          _buildStatusRow(
                            'MTU',
                            true,
                            statusText: '${_connectionState!.mtu}',
                          ),
                        ],
                        if (_connectionState!.error != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Error: ${_connectionState!.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ] else
                        const Text('No connection data available'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Saved Device Card
              if (_savedDevice != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saved Device',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildStatusRow(
                          'Device Name',
                          true,
                          statusText: _savedDevice!.deviceName,
                        ),
                        const SizedBox(height: 8),
                        _buildStatusRow(
                          'Device ID',
                          true,
                          statusText: _savedDevice!.deviceId,
                        ),
                        const SizedBox(height: 8),
                        _buildStatusRow(
                          'Connected At',
                          true,
                          statusText:
                              '${_savedDevice!.connectedAt.day}/${_savedDevice!.connectedAt.month}/${_savedDevice!.connectedAt.year} ${_savedDevice!.connectedAt.hour}:${_savedDevice!.connectedAt.minute.toString().padLeft(2, '0')}',
                        ),
                        if (_savedDevice!.mtu != null) ...[
                          const SizedBox(height: 8),
                          _buildStatusRow(
                            'MTU',
                            true,
                            statusText: '${_savedDevice!.mtu}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

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

              // Connection Buttons
              const Text(
                'BLE Connection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed:
                    (_isLoading ||
                        _connectionState?.status !=
                            BleConnectionStatus.connected)
                    ? null
                    : _disconnectFromDevice,
                icon: const Icon(Icons.bluetooth_disabled),
                label: const Text('Disconnect from Device'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _removeSavedDevice,
                icon: const Icon(Icons.delete),
                label: const Text('Remove Saved Device'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _showStoredDevicesDialog,
                icon: const Icon(Icons.storage),
                label: const Text('View All Stored Devices'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Service Discovery Buttons
              const Text(
                'Service & Characteristic Discovery',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed:
                    (_isLoading ||
                        _connectionState?.status !=
                            BleConnectionStatus.connected)
                    ? null
                    : _discoverServices,
                icon: const Icon(Icons.search),
                label: const Text('Discover All Services'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: (_isLoading || _discoveryResult == null)
                    ? null
                    : _showServicesDialog,
                icon: const Icon(Icons.list),
                label: const Text('View Discovered Services'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // ElevatedButton.icon(
              //   onPressed:
              //       (_isLoading ||
              //           _connectionState?.status !=
              //               BleConnectionStatus.connected)
              //       ? null
              //       : _showFindServiceDialog,
              //   icon: const Icon(Icons.find_in_page),
              //   label: const Text('Find Service by UUID'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.cyan,
              //     foregroundColor: Colors.white,
              //   ),
              // ),
              // const SizedBox(height: 12),
              //
              // ElevatedButton.icon(
              //   onPressed:
              //       (_isLoading ||
              //           _connectionState?.status !=
              //               BleConnectionStatus.connected)
              //       ? null
              //       : _showFindCharacteristicDialog,
              //   icon: const Icon(Icons.find_replace),
              //   label: const Text('Find Characteristic by UUID'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.deepOrange,
              //     foregroundColor: Colors.white,
              //   ),
              // ),
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
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('RSSI: ${device.rssi}'),
                                          Text(
                                            '${device.timestamp.hour}:${device.timestamp.minute.toString().padLeft(2, '0')}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: _isLoading
                                            ? null
                                            : () => _connectToDevice(
                                                device.device,
                                              ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              _connectionState
                                                          ?.device
                                                          .remoteId ==
                                                      device.device.remoteId &&
                                                  _connectionState?.status ==
                                                      BleConnectionStatus
                                                          .connected
                                              ? Colors.blue
                                              : Colors.green,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                        ),
                                        child: Text(
                                          _connectionState?.device.remoteId ==
                                                      device.device.remoteId &&
                                                  _connectionState?.status ==
                                                      BleConnectionStatus
                                                          .connected
                                              ? 'Connected'
                                              : 'Connect',
                                          style: const TextStyle(fontSize: 12),
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
                const SizedBox(height: 20),
              ],
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
