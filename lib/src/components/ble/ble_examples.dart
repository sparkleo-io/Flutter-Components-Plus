import 'package:flutter/material.dart';
import 'fcp_ble_component.dart';
import 'models/ble_device_model.dart';
import 'ble_manager.dart';

/// Example usage of the BLE component
class BLEExamples extends StatelessWidget {
  const BLEExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Component Examples'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BLE Component Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Basic Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            BasicBLEExample(),
            SizedBox(height: 30),
            Text(
              'Advanced Usage with Custom Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            AdvancedBLEExample(),
            SizedBox(height: 30),
            Text(
              'Custom UI Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CustomUIExample(),
            SizedBox(height: 30),
            Text(
              'Programmatic Usage Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ProgrammaticExample(),
          ],
        ),
      ),
    );
  }
}

/// Basic BLE component example
class BasicBLEExample extends StatelessWidget {
  const BasicBLEExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic BLE Component with default configuration',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This example shows the basic usage with default settings.',
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const FCPBLEComponent(
                config: BLEComponentConfig(
                  scanDuration: Duration(seconds: 10),
                  deviceFilters: ["Leo USB EVNC106P6"],

                  usePrefs: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Advanced BLE component example
class AdvancedBLEExample extends StatelessWidget {
  const AdvancedBLEExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced BLE Component with custom configuration',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This example shows advanced configuration with device filters, '
              'auto-connect, custom colors, and event callbacks.',
            ),
            const SizedBox(height: 10),
            Container(
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FCPBLEComponent(
                config: const BLEComponentConfig(
                  scanDuration: Duration(seconds: 15),
                  autoConnect: true,
                  deviceFilters: ['MyDevice', 'Sensor', 'BLE'],
                  usePrefs: true,
                  showPermissionDialog: true,
                  autoStartScan: false,
                  primaryColor: Colors.purple,
                  successColor: Colors.green,
                  errorColor: Colors.red,
                ),
                onDeviceSelected: (device) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected device: ${device.name}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                onConnectionStateChanged: (state) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Connection state: $state'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                onServicesDiscovered: (services) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Discovered ${services.length} services'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $error'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom UI example
class CustomUIExample extends StatefulWidget {
  const CustomUIExample({super.key});

  @override
  State<CustomUIExample> createState() => _CustomUIExampleState();
}

class _CustomUIExampleState extends State<CustomUIExample> {
  final List<BLEDeviceModel> _devices = [];
  BLEConnectionState _connectionState = BLEConnectionState.disconnected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom UI Example',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This example shows how to use custom UI builders for complete control over the interface.',
            ),
            const SizedBox(height: 10),
            Container(
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FCPBLEComponent(
                config: const BLEComponentConfig(
                  scanDuration: Duration(seconds: 10),
                  usePrefs: true,
                  showDeviceList: false,
                  showConnectionStatus: false,
                  showScanButton: false,
                  showDisconnectButton: false,
                ),
                customConnectionStatusBuilder: _buildCustomConnectionStatus(),
                customScanButtonBuilder: _buildCustomScanButton(),
                customDisconnectButtonBuilder: _buildCustomDisconnectButton(),
                customDeviceListBuilder: _buildCustomDeviceList(),
                onDevicesFound: (devices) {
                  setState(() {
                    _devices.clear();
                    _devices.addAll(devices);
                  });
                },
                onConnectionStateChanged: (state) {
                  setState(() {
                    _connectionState = state;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomConnectionStatus() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _connectionState == BLEConnectionState.connected
            ? Colors.green.shade100
            : Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _connectionState == BLEConnectionState.connected
              ? Colors.green
              : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _connectionState == BLEConnectionState.connected
                ? Icons.bluetooth_connected
                : Icons.bluetooth_disabled,
            color: _connectionState == BLEConnectionState.connected
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            'Status: ${_getConnectionStateText()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomScanButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton.icon(
        onPressed: () {
          // Scan functionality will be handled by the component
        },
        icon: const Icon(Icons.radar),
        label: const Text('Scan for Devices'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCustomDisconnectButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton.icon(
        onPressed: _connectionState == BLEConnectionState.connected
            ? () {
                // Disconnect functionality will be handled by the component
              }
            : null,
        icon: const Icon(Icons.bluetooth_disabled),
        label: const Text('Disconnect'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCustomDeviceList() {
    if (_devices.isEmpty) {
      return const Center(
        child: Text('No devices found. Start scanning to discover devices.'),
      );
    }

    return ListView.builder(
      itemCount: _devices.length,
      itemBuilder: (context, index) {
        final device = _devices[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: device.isConnected ? Colors.green : Colors.blue,
              child: Icon(
                device.isConnected
                    ? Icons.bluetooth_connected
                    : Icons.bluetooth,
                color: Colors.white,
              ),
            ),
            title: Text(
              device.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
                    onPressed: () {
                      // Connect functionality will be handled by the component
                    },
                    child: const Text('Connect'),
                  ),
          ),
        );
      },
    );
  }

  String _getConnectionStateText() {
    switch (_connectionState) {
      case BLEConnectionState.disconnected:
        return 'Disconnected';
      case BLEConnectionState.connecting:
        return 'Connecting...';
      case BLEConnectionState.connected:
        return 'Connected';
      case BLEConnectionState.disconnecting:
        return 'Disconnecting...';
      case BLEConnectionState.error:
        return 'Error';
    }
  }
}

/// Programmatic usage example
class ProgrammaticExample extends StatefulWidget {
  const ProgrammaticExample({super.key});

  @override
  State<ProgrammaticExample> createState() => _ProgrammaticExampleState();
}

class _ProgrammaticExampleState extends State<ProgrammaticExample> {
  final BLEManager _bleManager = BLEManager();
  final List<BLEDeviceModel> _devices = [];
  BLEConnectionState _connectionState = BLEConnectionState.disconnected;
  BLEScanState _scanState = BLEScanState.idle;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeBLE();
  }

  @override
  void dispose() {
    _bleManager.dispose();
    super.dispose();
  }

  Future<void> _initializeBLE() async {
    try {
      await _bleManager.initialize(
        scanDuration: const Duration(seconds: 10),
        usePrefs: true,
      );

      // Listen to events
      _bleManager.deviceFoundStream.listen((device) {
        setState(() {
          final existingIndex = _devices.indexWhere((d) => d.id == device.id);
          if (existingIndex != -1) {
            _devices[existingIndex] = device;
          } else {
            _devices.add(device);
          }
        });
      });

      _bleManager.connectionStateStream.listen((state) {
        setState(() {
          _connectionState = state;
        });
      });

      _bleManager.scanStateStream.listen((state) {
        setState(() {
          _scanState = state;
        });
      });

      _bleManager.errorStream.listen((error) {
        setState(() {
          _error = error;
        });
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize BLE: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Programmatic Usage Example',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This example shows how to use the BLEManager directly for programmatic control.',
            ),
            const SizedBox(height: 10),
            if (_error != null)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Text(
                  'Error: $_error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _scanState == BLEScanState.scanning
                      ? _bleManager.stopScan
                      : _bleManager.startScan,
                  icon: _scanState == BLEScanState.scanning
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.search),
                  label: Text(
                    _scanState == BLEScanState.scanning
                        ? 'Stop Scan'
                        : 'Start Scan',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _connectionState == BLEConnectionState.connected
                      ? _bleManager.disconnectDevice
                      : null,
                  icon: const Icon(Icons.bluetooth_disabled),
                  label: const Text('Disconnect'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _devices.isEmpty
                  ? const Center(
                      child: Text(
                        'No devices found. Start scanning to discover devices.',
                      ),
                    )
                  : ListView.builder(
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        final device = _devices[index];
                        return ListTile(
                          leading: Icon(
                            device.isConnected
                                ? Icons.bluetooth_connected
                                : Icons.bluetooth,
                            color: device.isConnected
                                ? Colors.green
                                : Colors.blue,
                          ),
                          title: Text(device.name),
                          subtitle: Text('RSSI: ${device.rssi} dBm'),
                          trailing: device.isConnected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : ElevatedButton(
                                  onPressed: () =>
                                      _bleManager.connectToDevice(device),
                                  child: const Text('Connect'),
                                ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
