import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Model class representing a BLE device with all its details
class BLEDeviceModel {
  final String id;
  final String name;
  final String macAddress;
  final int rssi;
  final List<BLEServiceModel> services;
  final DateTime lastSeen;
  final bool isConnected;
  final Map<String, dynamic> advertisementData;

  const BLEDeviceModel({
    required this.id,
    required this.name,
    required this.macAddress,
    required this.rssi,
    required this.services,
    required this.lastSeen,
    this.isConnected = false,
    this.advertisementData = const {},
  });

  /// Create BLEDeviceModel from BluetoothDevice
  factory BLEDeviceModel.fromBluetoothDevice(
    BluetoothDevice device, {
    int rssi = 0,
    Map<String, dynamic> advertisementData = const {},
    List<BLEServiceModel> services = const [],
  }) {
    return BLEDeviceModel(
      id: device.remoteId.toString(),
      name: device.platformName.isNotEmpty
          ? device.platformName
          : 'Unknown Device',
      macAddress: device.remoteId.toString(),
      rssi: rssi,
      services: services,
      lastSeen: DateTime.now(),
      isConnected: device.isConnected,
      advertisementData: advertisementData,
    );
  }

  /// Create BLEDeviceModel from JSON
  factory BLEDeviceModel.fromJson(Map<String, dynamic> json) {
    return BLEDeviceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      macAddress: json['macAddress'] as String,
      rssi: json['rssi'] as int,
      services: (json['services'] as List<dynamic>)
          .map(
            (service) =>
                BLEServiceModel.fromJson(service as Map<String, dynamic>),
          )
          .toList(),
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      isConnected: json['isConnected'] as bool? ?? false,
      advertisementData:
          json['advertisementData'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Convert BLEDeviceModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'macAddress': macAddress,
      'rssi': rssi,
      'services': services.map((service) => service.toJson()).toList(),
      'lastSeen': lastSeen.toIso8601String(),
      'isConnected': isConnected,
      'advertisementData': advertisementData,
    };
  }

  /// Convert BLEDeviceModel to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Create BLEDeviceModel from JSON string
  factory BLEDeviceModel.fromJsonString(String jsonString) {
    return BLEDeviceModel.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }

  /// Create a copy of this model with updated fields
  BLEDeviceModel copyWith({
    String? id,
    String? name,
    String? macAddress,
    int? rssi,
    List<BLEServiceModel>? services,
    DateTime? lastSeen,
    bool? isConnected,
    Map<String, dynamic>? advertisementData,
  }) {
    return BLEDeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      macAddress: macAddress ?? this.macAddress,
      rssi: rssi ?? this.rssi,
      services: services ?? this.services,
      lastSeen: lastSeen ?? this.lastSeen,
      isConnected: isConnected ?? this.isConnected,
      advertisementData: advertisementData ?? this.advertisementData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BLEDeviceModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'BLEDeviceModel(id: $id, name: $name, macAddress: $macAddress, rssi: $rssi, isConnected: $isConnected)';
  }
}

/// Model class representing a BLE service
class BLEServiceModel {
  final String uuid;
  final String name;
  final List<BLECharacteristicModel> characteristics;
  final bool isPrimary;

  const BLEServiceModel({
    required this.uuid,
    required this.name,
    required this.characteristics,
    this.isPrimary = true,
  });

  /// Create BLEServiceModel from BluetoothService
  factory BLEServiceModel.fromBluetoothService(BluetoothService service) {
    return BLEServiceModel(
      uuid: service.uuid.toString(),
      name: service.uuid
          .toString(), // You can map this to a human-readable name
      characteristics: service.characteristics
          .map(
            (char) => BLECharacteristicModel.fromBluetoothCharacteristic(char),
          )
          .toList(),
      isPrimary: service.isPrimary,
    );
  }

  /// Create BLEServiceModel from JSON
  factory BLEServiceModel.fromJson(Map<String, dynamic> json) {
    return BLEServiceModel(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      characteristics: (json['characteristics'] as List<dynamic>)
          .map(
            (char) =>
                BLECharacteristicModel.fromJson(char as Map<String, dynamic>),
          )
          .toList(),
      isPrimary: json['isPrimary'] as bool? ?? true,
    );
  }

  /// Convert BLEServiceModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'characteristics': characteristics.map((char) => char.toJson()).toList(),
      'isPrimary': isPrimary,
    };
  }

  @override
  String toString() {
    return 'BLEServiceModel(uuid: $uuid, name: $name, characteristics: ${characteristics.length})';
  }
}

/// Model class representing a BLE characteristic
class BLECharacteristicModel {
  final String uuid;
  final String name;
  final List<String> properties;
  final List<int>? value;
  final String? descriptor;

  const BLECharacteristicModel({
    required this.uuid,
    required this.name,
    required this.properties,
    this.value,
    this.descriptor,
  });

  /// Create BLECharacteristicModel from BluetoothCharacteristic
  factory BLECharacteristicModel.fromBluetoothCharacteristic(
    BluetoothCharacteristic characteristic,
  ) {
    return BLECharacteristicModel(
      uuid: characteristic.uuid.toString(),
      name: characteristic.uuid
          .toString(), // You can map this to a human-readable name
      properties: [
        if (characteristic.properties.read) 'read',
        if (characteristic.properties.write) 'write',
        if (characteristic.properties.writeWithoutResponse)
          'writeWithoutResponse',
        if (characteristic.properties.notify) 'notify',
        if (characteristic.properties.indicate) 'indicate',
      ],
      value: characteristic.lastValue,
      descriptor: characteristic.descriptors.isNotEmpty
          ? characteristic.descriptors.first.uuid.toString()
          : null,
    );
  }

  /// Create BLECharacteristicModel from JSON
  factory BLECharacteristicModel.fromJson(Map<String, dynamic> json) {
    return BLECharacteristicModel(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      properties: (json['properties'] as List<dynamic>).cast<String>(),
      value: json['value'] != null
          ? (json['value'] as List<dynamic>).cast<int>()
          : null,
      descriptor: json['descriptor'] as String?,
    );
  }

  /// Convert BLECharacteristicModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'properties': properties,
      'value': value,
      'descriptor': descriptor,
    };
  }

  @override
  String toString() {
    return 'BLECharacteristicModel(uuid: $uuid, name: $name, properties: $properties)';
  }
}
