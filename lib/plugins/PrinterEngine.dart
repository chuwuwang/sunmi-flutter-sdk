import 'package:flutter/services.dart';

class PrinterEngine {

  static const MethodChannel _channel = MethodChannel("printer-engine");

  static Future<String> initPrinter() async {
    return await _channel.invokeMethod("initPrinter");
  }

  static Future<int> getPrinterStatus() async {
    return await _channel.invokeMethod("getPrinterStatus");
  }

  static Future<String> reset() async {
    return await _channel.invokeMethod("reset");
  }

  static Future<String> setBold(bool isBold) async {
    return await _channel.invokeMethod("setFontBold", isBold);
  }

  static Future<String> setFontSize(int fontSize) async {
    return await _channel.invokeMethod("setFontSize", fontSize);
  }

  static Future<String> setAlignment(int alignment) async {
    return await _channel.invokeMethod("setFontAlignment", alignment);
  }

  static Future<String> setRowHeight(int rowHeight) async {
    return await _channel.invokeMethod("setFontRowHeight", rowHeight);
  }

  static Future<String> printText(String text) async {
    return await _channel.invokeMethod("printText", text);
  }

  static Future<String> printImage(Uint8List data) async {
    return await _channel.invokeMethod("printImage", data);
  }

  static Future<String> printBarcode(String data, int symbology, int height, int width, int textPosition,) async {
    var parameter = {
      "data": data,
      "symbology": symbology,
      "height": height,
      "width": width,
      "textPosition": textPosition
    };
    return await _channel.invokeMethod("printBarcode", parameter);
  }

  static Future<String> printQRCode(String data, int moduleSize, int errorLevel) async {
    var parameter = {
      "data": data,
      "moduleSize": moduleSize,
      "errorLevel": errorLevel
    };
    return await _channel.invokeMethod("printQRCode", parameter);
  }

  static Future<String> printTable(List<String> columnText, List<int> columnWidth, List<int> columnAlign) async {
    var parameter = {
      "columnText": columnText,
      "columnWidth": columnWidth,
      "columnAlign": columnAlign
    };
    return await _channel.invokeMethod("printTable", parameter);
  }

  static Future<String> printLine(int line) async {
    return await _channel.invokeMethod("printLine", line);
  }

  static Future<void> enterPrinterBuffer() async {
    return await _channel.invokeMethod("enterPrinterBuffer");
  }

  static Future<String> exitPrinterBuffer() async {
    return await _channel.invokeMethod("exitPrinterBuffer");
  }

}