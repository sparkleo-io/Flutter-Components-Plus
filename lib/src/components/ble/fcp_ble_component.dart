import 'dart:async';
import 'package:flutter/material.dart';
import 'models/ble_device_model.dart';
import 'ble_manager.dart';
import 'permission_handler.dart';

/// Configuration class for BLE component
class BLEComponentConfig {
  final Duration scanDuration;
  final bool autoConnect;
  final List<String> deviceFilters;
  final bool usePrefs;
  final bool showPermissionDialog;
  final String? permissionDialogTitle;
  final String? permissionDialogMessage;
  final String? permissionDialogConfirmText;
  final String? permissionDialogCancelText;
  final bool autoStartScan;
  final bool showDeviceList;
  final bool showConnectionStatus;
  final bool showScanButton;
  final bool showDisconnectButton;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;
  final Color? successColor;
  final bool debugMode;
  final bool showAllDevices; // Temporary option to bypass filters for testing
  final bool alwaysScan;
  final bool androidUsesFineLocation;
  final bool saveScanDevices;

  const BLEComponentConfig({
    this.scanDuration = const Duration(seconds: 10),
    this.autoConnect = false,
    this.deviceFilters = const [],
    this.usePrefs = false,
    this.showPermissionDialog = true,
    this.permissionDialogTitle,
    this.permissionDialogMessage,
    this.permissionDialogConfirmText,
    this.permissionDialogCancelText,
    this.autoStartScan = false,
    this.showDeviceList = true,
    this.showConnectionStatus = true,
    this.showScanButton = true,
    this.showDisconnectButton = true,
    this.primaryColor,
    this.secondaryColor,
    this.errorColor,
    this.successColor,
    this.debugMode = false,
    this.showAllDevices = false,
    this.alwaysScan = false,
    this.androidUsesFineLocation = true,
    this.saveScanDevices = false,
  });
}

/// Main BLE component widget
class FCPBLEComponent extends StatefulWidget {
  final BLEComponentConfig config;
  final Widget? customDeviceListBuilder;
  final Widget? customConnectionStatusBuilder;
  final Widget? customScanButtonBuilder;
  final Widget? customDisconnectButtonBuilder;
  final Function(BLEDeviceModel)? onDeviceSelected;
  final Function(BLEConnectionState)? onConnectionStateChanged;
  final Function(List<BLEServiceModel>)? onServicesDiscovered;
  final Function(String)? onError;
  final Function(List<BLEDeviceModel>)? onDevicesFound;

  const FCPBLEComponent({
    super.key,
    required this.config,
    this.customDeviceListBuilder,
    this.customConnectionStatusBuilder,
    this.customScanButtonBuilder,
    this.customDisconnectButtonBuilder,
    this.onDeviceSelected,
    this.onConnectionStateChanged,
    this.onServicesDiscovered,
    this.onError,
    this.onDevicesFound,
  });

  @override
  State<FCPBLEComponent> createState() => _FCPBLEComponentState();
}

class _FCPBLEComponentState extends State<FCPBLEComponent> {
  final BLEManager _bleManager = BLEManager();
  final List<BLEDeviceModel> _devices = [];
  final List<BLEServiceModel> _services = [];

  BLEConnectionState _connectionState = BLEConnectionState.disconnected;
  BLEScanState _scanState = BLEScanState.idle;
  String? _error;
  bool _permissionsGranted = false;
  bool _isInitialized = false;

  StreamSubscription<BLEDeviceModel>? _deviceFoundSubscription;
  StreamSubscription<BLEConnectionState>? _connectionStateSubscription;
  StreamSubscription<BLEScanState>? _scanStateSubscription;
  StreamSubscription<String>? _errorSubscription;
  StreamSubscription<List<BLEServiceModel>>? _servicesSubscription;

  @override
  void initState() {
    super.initState();
    _initializeBLE();
  }

  @override
  void dispose() {
    _deviceFoundSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    _scanStateSubscription?.cancel();
    _errorSubscription?.cancel();
    _servicesSubscription?.cancel();
    _bleManager.dispose();
    super.dispose();
  }

  /// Initialize BLE component
  Future<void> _initializeBLE() async {
    try {
      // Check permissions first
      if (widget.config.showPermissionDialog) {
        _permissionsGranted = await BLEPermissionHandler.ensureBLERequirements(
          context,
          title: widget.config.permissionDialogTitle,
          message: widget.config.permissionDialogMessage,
          confirmText: widget.config.permissionDialogConfirmText,
          cancelText: widget.config.permissionDialogCancelText,
        );
      } else {
        _permissionsGranted =
            await BLEPermissionHandler.areAllPermissionsGranted();
      }

      if (!_permissionsGranted) {
        setState(() {
          _error = 'Required permissions not granted';
        });
        return;
      }

      // Initialize BLE manager
      await _bleManager.initialize(
        scanDuration: widget.config.scanDuration,
        autoConnect: widget.config.autoConnect,
        deviceFilters: widget.config.deviceFilters,
        usePrefs: widget.config.usePrefs,
        debugMode: widget.config.debugMode,
        showAllDevices: widget.config.showAllDevices,
        alwaysScan: widget.config.alwaysScan,
        androidUsesFineLocation: widget.config.androidUsesFineLocation,
        saveScanDevices: widget.config.saveScanDevices,
      );

      // Set up stream subscriptions
      _setupStreamSubscriptions();

      // Load saved devices if using preferences
      if (widget.config.usePrefs) {
        final savedDevices = await _bleManager.getSavedDevices();
        setState(() {
          _devices.addAll(savedDevices);
        });
      }

      setState(() {
        _isInitialized = true;
      });

      // Auto-start scan if configured
      if (widget.config.autoStartScan) {
        await startScan();
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize BLE: $e';
      });
    }
  }

  /// Set up stream subscriptions
  void _setupStreamSubscriptions() {
    _deviceFoundSubscription = _bleManager.deviceFoundStream.listen((device) {
      setState(() {
        final existingIndex = _devices.indexWhere((d) => d.id == device.id);
        if (existingIndex != -1) {
          _devices[existingIndex] = device;
        } else {
          _devices.add(device);
        }
      });
      widget.onDevicesFound?.call(_devices);
    });

    _connectionStateSubscription = _bleManager.connectionStateStream.listen((
      state,
    ) {
      setState(() {
        _connectionState = state;
      });
      widget.onConnectionStateChanged?.call(state);
    });

    _scanStateSubscription = _bleManager.scanStateStream.listen((state) {
      setState(() {
        _scanState = state;
      });
    });

    _errorSubscription = _bleManager.errorStream.listen((error) {
      setState(() {
        _error = error;
      });
      widget.onError?.call(error);
    });

    _servicesSubscription = _bleManager.servicesDiscoveredStream.listen((
      services,
    ) {
      setState(() {
        _services.clear();
        _services.addAll(services);
      });
      widget.onServicesDiscovered?.call(services);
    });
  }

  /// Start scanning for devices
  Future<void> startScan() async {
    if (!_isInitialized || !_permissionsGranted) return;

    try {
      await _bleManager.startScan();
    } catch (e) {
      setState(() {
        _error = 'Failed to start scan: $e';
      });
    }
  }

  /// Stop scanning for devices
  Future<void> stopScan() async {
    if (!_isInitialized) return;

    try {
      await _bleManager.stopScan();
    } catch (e) {
      setState(() {
        _error = 'Failed to stop scan: $e';
      });
    }
  }

  /// Connect to a device
  Future<void> connectToDevice(BLEDeviceModel device) async {
    if (!_isInitialized) return;

    try {
      await _bleManager.connectToDevice(device);
      widget.onDeviceSelected?.call(device);
    } catch (e) {
      setState(() {
        _error = 'Failed to connect to device: $e';
      });
    }
  }

  /// Disconnect from current device
  Future<void> disconnectDevice() async {
    if (!_isInitialized) return;

    try {
      await _bleManager.disconnectDevice();
    } catch (e) {
      setState(() {
        _error = 'Failed to disconnect device: $e';
      });
    }
  }

  /// Read characteristic
  Future<List<int>?> readCharacteristic(
    String serviceUuid,
    String characteristicUuid,
  ) async {
    if (!_isInitialized) return null;

    try {
      return await _bleManager.readCharacteristic(
        serviceUuid,
        characteristicUuid,
      );
    } catch (e) {
      setState(() {
        _error = 'Failed to read characteristic: $e';
      });
      return null;
    }
  }

  /// Write characteristic
  Future<bool> writeCharacteristic(
    String serviceUuid,
    String characteristicUuid,
    List<int> value, {
    bool withoutResponse = false,
  }) async {
    if (!_isInitialized) return false;

    try {
      return await _bleManager.writeCharacteristic(
        serviceUuid,
        characteristicUuid,
        value,
        withoutResponse: withoutResponse,
      );
    } catch (e) {
      setState(() {
        _error = 'Failed to write characteristic: $e';
      });
      return false;
    }
  }

  /// Get saved devices
  Future<List<BLEDeviceModel>> getSavedDevices() async {
    if (!_isInitialized) return [];

    try {
      return await _bleManager.getSavedDevices();
    } catch (e) {
      setState(() {
        _error = 'Failed to get saved devices: $e';
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_permissionsGranted) {
      return _buildPermissionError();
    }

    if (_error != null) {
      return _buildErrorWidget();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.config.showConnectionStatus) _buildConnectionStatus(),
          if (widget.config.showScanButton ||
              widget.config.showDisconnectButton)
            _buildActionButtons(),
          if (widget.config.showDeviceList) _buildDeviceList(),
          if (_services.isNotEmpty) _buildServicesList(),
        ],
      ),
    );
  }

  /// Build permission error widget
  Widget _buildPermissionError() {
    return Card(
      color: widget.config.errorColor ?? Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: widget.config.errorColor ?? Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Permissions Required',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This app needs Bluetooth and Location permissions to work with BLE devices.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final granted =
                    await BLEPermissionHandler.requestPermissionsWithDialog(
                      context,
                    );
                if (granted) {
                  setState(() {
                    _permissionsGranted = true;
                    _error = null;
                  });
                  _initializeBLE();
                }
              },
              child: const Text('Grant Permissions'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build error widget
  Widget _buildErrorWidget() {
    return Card(
      color: widget.config.errorColor ?? Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: widget.config.errorColor ?? Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                });
                _initializeBLE();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build connection status widget
  Widget _buildConnectionStatus() {
    if (widget.customConnectionStatusBuilder != null) {
      return widget.customConnectionStatusBuilder!;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              _connectionState == BLEConnectionState.connected
                  ? Icons.bluetooth_connected
                  : Icons.bluetooth_disabled,
              color: _connectionState == BLEConnectionState.connected
                  ? (widget.config.successColor ?? Colors.green)
                  : (widget.config.errorColor ?? Colors.red),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connection Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.config.primaryColor,
                    ),
                  ),
                  Text(_getConnectionStateText()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.config.showScanButton) _buildScanButton(),
          if (widget.config.showDisconnectButton) _buildDisconnectButton(),
        ],
      ),
    );
  }

  /// Build scan button
  Widget _buildScanButton() {
    if (widget.customScanButtonBuilder != null) {
      return widget.customScanButtonBuilder!;
    }

    final isScanning = _scanState == BLEScanState.scanning;

    return ElevatedButton.icon(
      onPressed: isScanning ? stopScan : startScan,
      icon: isScanning
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.search),
      label: Text(isScanning ? 'Stop Scan' : 'Start Scan'),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.config.primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Build disconnect button
  Widget _buildDisconnectButton() {
    if (widget.customDisconnectButtonBuilder != null) {
      return widget.customDisconnectButtonBuilder!;
    }

    return ElevatedButton.icon(
      onPressed: _connectionState == BLEConnectionState.connected
          ? disconnectDevice
          : null,
      icon: const Icon(Icons.bluetooth_disabled),
      label: const Text('Disconnect'),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.config.errorColor ?? Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Build device list
  Widget _buildDeviceList() {
    if (widget.customDeviceListBuilder != null) {
      return widget.customDeviceListBuilder!;
    }

    if (_devices.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Text(
              'No devices found. Start scanning to discover devices.',
            ),
          ),
        ),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return _buildDeviceListItem(device);
        },
      ),
    );
  }

  /// Build device list item
  Widget _buildDeviceListItem(BLEDeviceModel device) {
    final isConnected = device.isConnected;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          isConnected ? Icons.bluetooth_connected : Icons.bluetooth,
          color: isConnected
              ? (widget.config.successColor ?? Colors.green)
              : (widget.config.primaryColor ?? Colors.blue),
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
        trailing: isConnected
            ? Icon(
                Icons.check_circle,
                color: widget.config.successColor ?? Colors.green,
              )
            : ElevatedButton(
                onPressed: () => connectToDevice(device),
                child: const Text('Connect'),
              ),
        onTap: () => connectToDevice(device),
      ),
    );
  }

  /// Build services list
  Widget _buildServicesList() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discovered Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.config.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  return _buildServiceItem(_services[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build service item
  Widget _buildServiceItem(BLEServiceModel service) {
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
  }

  /// Get connection state text
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
        return 'Connection Error';
    }
  }
}
