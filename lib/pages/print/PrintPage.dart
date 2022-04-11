// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          WidgetHelper.itemWidget('Set font bold', false, () {  } ),
          WidgetHelper.itemWidget('Set font size', false, () {  } ),
          WidgetHelper.itemWidget('Set alignment', false, () {  } ),
          WidgetHelper.itemWidget('Set row height', false, () {  } ),
          WidgetHelper.itemWidget('Print text', false, () {  } ),
          WidgetHelper.itemWidget('Print image', false, () {  } ),
          WidgetHelper.itemWidget('Print barcode', false, () {  } ),
          WidgetHelper.itemWidget('Print qrcode', false, () {  } ),
          WidgetHelper.itemWidget('Print table', false, () {  } ),
          WidgetHelper.itemWidget('Print line', false, () {  } ),
          WidgetHelper.itemWidget('Enter printer buffer', false, () {  } ),
          WidgetHelper.itemWidget('Exit printer buffer', false, () {  } ),
        ],
      ),
    );
  }

  _initPrinter() {
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

}