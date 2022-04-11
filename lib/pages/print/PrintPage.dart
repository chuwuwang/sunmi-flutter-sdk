// ignore_for_file: avoid_print
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sun_mi_flutter_sdk/plugins/PrinterEngine.dart';
import 'package:sun_mi_flutter_sdk/widget/WidgetHelper.dart';

class PrintPage extends StatelessWidget {

  const PrintPage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Print'), ),
      body: _mainView(context),
    );
  }

  _mainView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetHelper.itemWidget('Initialize printer', false, () { _initPrinter(); } ),
          WidgetHelper.itemWidget('Get printer status', false, () { _getPrinterStatus(); } ),
          WidgetHelper.itemWidget('Reset printer', false, () { _reset(); } ),
          WidgetHelper.itemWidget('Set font bold', false, () { _setBold(); } ),
          WidgetHelper.itemWidget('Set font size', false, () { _setFontSize(); } ),
          WidgetHelper.itemWidget('Set alignment', false, () { _setAlignment(1); } ),
          WidgetHelper.itemWidget('Set row height', false, () { _setRowHeight(); } ),
          WidgetHelper.itemWidget('Print text', false, () { _printText(); } ),
          WidgetHelper.itemWidget('Print image', false, () { _printImage(); } ),
          WidgetHelper.itemWidget('Print barcode', false, () { _printBarcode(); } ),
          WidgetHelper.itemWidget('Print qrcode', false, () { _printQRCode(); } ),
          WidgetHelper.itemWidget('Print table', false, () { _printTable(); } ),
          WidgetHelper.itemWidget('Print line', false, () { _printLine(); } ),
          WidgetHelper.itemWidget('Enter printer buffer', false, () { _enterPrinterBuffer(); } ),
          WidgetHelper.itemWidget('Exit printer buffer', false, () { _exitPrinterBuffer(); } ),
        ],
      ),
    );
  }

  _initPrinter() {
    PrinterEngine.initPrinter(
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _getPrinterStatus() {
    PrinterEngine.getPrinterStatus().then(
      (value) => {
        Fluttertoast.showToast(msg: 'status: $value')
      }
    );
  }

  _reset() {
    PrinterEngine.reset(
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _setBold() {
    PrinterEngine.setBold(true,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _setFontSize() {
    PrinterEngine.setFontSize(40,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _setAlignment(int alignment) {
    PrinterEngine.setAlignment(alignment,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _setRowHeight() {
    PrinterEngine.setRowHeight(40,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _printText() {
    PrinterEngine.printText("I believe there is a person who brings sunshine into your life. That person may have enough to spread around. But if you really have to wait for someone to bring you the sun and give you a good feeling, then you may have to wait a long time.",
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _printImage() {
    image2Bytes("images/printer.png").then(
      (value) => {
        PrinterEngine.printImage(value,
          (code, message) => {
            Fluttertoast.showToast(msg: '$message ($code)')
          }
        ).then(
          (value) => {
            Fluttertoast.showToast(msg: value)
          }
        )
      }
    );
  }

  _printBarcode() {
    PrinterEngine.printBarcode("0123456789123", 8, 162, 2, 2,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _printQRCode() {
    _setAlignment(1);
    PrinterEngine.printQRCode("0123456789123", 8, 3,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
    _setAlignment(2);
  }

  _printTable() {
    var columnText = ["Green Tea", "1", "4000"];
    var columnWidth = [2, 1, 1];
    var columnAlign = [1, 0, 2];
    PrinterEngine.printTable(columnText, columnWidth, columnAlign,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _printLine() {
    PrinterEngine.printLine(6,
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
  }

  _enterPrinterBuffer() {
    PrinterEngine.enterPrinterBuffer();
  }

  _exitPrinterBuffer() {
    PrinterEngine.exitPrinterBuffer(
      (code, message) => {
        Fluttertoast.showToast(msg: '$message ($code)')
      }
    ).then(
      (value) => {
        Fluttertoast.showToast(msg: value)
      }
    );
    _line();
  }

  _line() {
    PrinterEngine.printLine(4, (code, message) => null);
  }

  static Future<Uint8List> image2Bytes(String path) async {
    var byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  }

}