// ignore_for_file: avoid_print
import 'package:flutter/services.dart';

class ScanEngine {

  static const MethodChannel _channel = MethodChannel("scan-engine");

  static Future<Map> startScan() async {
    try {
      return await _channel.invokeMethod("startScan");
    } on PlatformException catch (e) {
      print(e);
    }
    return {};
  }

}