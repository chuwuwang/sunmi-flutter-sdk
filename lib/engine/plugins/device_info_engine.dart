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

  static const int navigationBarItemKeyBack = 4194304;
  static const int navigationBarItemKeyHome = 2097152;
  static const int navigationBarItemKeyRecent = 16777216;

  static Future<String> getSystemParameters(String parameter) async {
    return await _channel.invokeMethod("getSystemParameters", parameter);
  }

  static enableScreenMonopoly() async {
    await _channel.invokeMethod("enableScreenMonopoly");
  }

  static disableScreenMonopoly() async {
    await _channel.invokeMethod("disableScreenMonopoly");
  }

  static enableStatusBarDropDown() async {
    await _channel.invokeMethod("enableStatusBarDropDown");
  }

  static disableStatusBarDropDown() async {
    await _channel.invokeMethod("disableStatusBarDropDown");
  }

  static showNavigationBar() async {
    await _channel.invokeMethod("showNavigationBar");
  }

  static hideNavigationBar() async {
    await _channel.invokeMethod("hideNavigationBar");
  }

  static hideNavigationBarItemKey(int key) async {
    await _channel.invokeMethod("hideNavigationBarItemKey", key);
  }

}
