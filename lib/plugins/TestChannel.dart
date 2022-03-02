import 'package:flutter/services.dart';

class TestPlugin {

  static const MethodChannel _channel = MethodChannel("test-remote-plugin");

  static Future<String> getSystemParameters() async {
    return await _channel.invokeMethod("getSystemParameters");
  }

}
