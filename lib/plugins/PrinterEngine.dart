// ignore_for_file: avoid_print
import 'dart:typed_data';

import 'package:flutter/services.dart';

class PrinterEngine {

  static const MethodChannel _channel = MethodChannel("printer-engine");

  static Future<String> initPrinter(Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("initPrinter");
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
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

  static Future<String> setBold(bool isBold, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("setBold", isBold);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> setFontSize(int fontSize, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("setFontSize", fontSize);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> setAlignment(int alignment, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("setAlignment", alignment);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> setRowHeight(int rowHeight, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("setRowHeight", rowHeight);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> printText(String text, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("printText", text);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> printImage(Uint8List data, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("printImage", data);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> printBarcode(String data, int symbology, int height, int width, int textPosition, Function(String code, String ? message) error) async {
    try {
      var parameter = {
        "data": data,
        "symbology": symbology,
        "height": height,
        "width": width,
        "textPosition": textPosition
      };
      return await _channel.invokeMethod("printBarcode", parameter);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> printQRCode(String data, int moduleSize, int errorLevel, Function(String code, String ? message) error) async {
    try {
      var parameter = {
        "data": data,
        "moduleSize": moduleSize,
        "errorLevel": errorLevel
      };
      return await _channel.invokeMethod("printQRCode", parameter);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> printTable(List<String> columnText, List<int> columnWidth, List<int> columnAlign, Function(String code, String ? message) error) async {
    try {
      var parameter = {
        "columnText": columnText,
        "columnWidth": columnWidth,
        "columnAlign": columnAlign
      };
      return await _channel.invokeMethod("printTable", parameter);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<String> printLine(int line, Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("printLine", line);
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

  static Future<void> enterPrinterBuffer() async {
    try {
      return await _channel.invokeMethod("enterPrinterBuffer");
    } on PlatformException catch (e) {
      print(e);
    }
  }

  static Future<String> exitPrinterBuffer(Function(String code, String ? message) error) async {
    try {
      return await _channel.invokeMethod("exitPrinterBuffer");
    } on PlatformException catch (e) {
      print(e);
      error(e.code, e.message);
      return "";
    }
  }

}