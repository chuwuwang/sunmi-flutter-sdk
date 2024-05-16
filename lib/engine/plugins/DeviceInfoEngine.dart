// ignore_for_file: avoid_print
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
    try {
      return await _channel.invokeMethod("getSystemParameters", parameter);
    } on Exception catch (e) {
      print(e);
      return "";
    }
  }

  static enableScreenMonopoly() async {
    try {
      await _channel.invokeMethod("enableScreenMonopoly");
    } on Exception catch (e) {
      print(e);
    }
  }

  static disableScreenMonopoly() async {
    try {
      await _channel.invokeMethod("disableScreenMonopoly");
    } on Exception catch (e) {
      print(e);
    }
  }

  static enableStatusBarDropDown() async {
    try {
      await _channel.invokeMethod("enableStatusBarDropDown");
    } on Exception catch (e) {
      print(e);
    }
  }

  static disableStatusBarDropDown() async {
    try {
      await _channel.invokeMethod("disableStatusBarDropDown");
    } on Exception catch (e) {
      print(e);
    }
  }

  static showNavigationBar() async {
    try {
      await _channel.invokeMethod("showNavigationBar");
    } on Exception catch (e) {
      print(e);
    }
  }

  static hideNavigationBar() async {
    try {
      await _channel.invokeMethod("hideNavigationBar");
    } on Exception catch (e) {
      print(e);
    }
  }

  static hideNavigationBarItemKey(int key) async {
    try {
      await _channel.invokeMethod("hideNavigationBarItemKey", key);
    } on Exception catch (e) {
      print(e);
    }
  }

}