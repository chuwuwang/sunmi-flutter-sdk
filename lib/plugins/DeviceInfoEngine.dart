import 'package:flutter/services.dart';

class DeviceInfoEngine {

  static const MethodChannel _channel = MethodChannel("device-info-engine");

  static Future<String> getSystemParameters(String parameter) async {
    return await _channel.invokeMethod("getSystemParameters", parameter);
  }

}