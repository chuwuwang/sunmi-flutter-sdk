import 'package:flutter/services.dart';

class DeviceInfoEngine {

  static const MethodChannel _channel = MethodChannel("device-info-engine");

  static const String deviceCode = "deviceCode";
  static const String deviceModel = "deviceModel";
  static const String deviceBrand = "deviceBrand";
  static const String serialNumber = "serialNumber";
  static const String systemVersionName = "systemVersionName";
  static const String systemVersionCode = "systemVersionCode";
  static const String debugMode = "debugMode";
  static const String pn = "PN";
  static const String terminalUniqueSerialNumber = "terminalUniqueSerialNumber";
  static const String firmwareVersion = "firmwareVersion";
  static const String hardwareVersion = "hardwareVersion";
  static const String reserved = "reserved";
  static const String supportETC = "supportETC";

  static Future<String> getSystemParameters(String parameter) async {
    return await _channel.invokeMethod("getSystemParameters", parameter);
  }

}