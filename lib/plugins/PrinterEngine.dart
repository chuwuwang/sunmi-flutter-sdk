// ignore_for_file: avoid_print
import 'package:flutter/services.dart';

class PrinterEngine {

  static const MethodChannel _channel = MethodChannel("printer-engine");

  static Future<String> initPrinter() async {
    return await _channel.invokeMethod("initPrinter");
  }

  static Future<int> getPrinterStatus() async {
    try {
      return await _channel.invokeMethod("getPrinterStatus");
    } on Exception catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<String> reset(Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("reset");
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

}