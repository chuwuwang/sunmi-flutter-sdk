import 'package:flutter/services.dart';

class ScanEngine {

  static const MethodChannel _channel = MethodChannel("scanner-engine");

  static Future<Map> startScan() async {
    return await _channel.invokeMethod("startScan");
  }

}