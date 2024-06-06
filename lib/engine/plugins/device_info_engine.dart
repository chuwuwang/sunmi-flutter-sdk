import 'package:flutter/services.dart';

class DeviceInfoEngine {

  static const MethodChannel _channel = MethodChannel("device-info-engine");

  static Future<String> getSystemParameters(String parameter) async {
    return await _channel.invokeMethod("getSystemParameters", parameter);
  }

  static buzzer(int time, int delay) async {
    var parameter = {"time": time, "delay": delay};
    return await _channel.invokeMethod("buzzer", parameter);
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
