// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sun_mi_flutter_sdk/plugins/PrinterEngine.dart';

class PrintPage extends StatelessWidget {

  const PrintPage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = const Text("Print");
    var appBar = AppBar(title: text);
    var body = _mainView(context);
    return Scaffold(appBar: appBar, body: body);
  }

  _mainView(BuildContext context) {
    List<Widget> children = [
      const SizedBox(height: 16),
      _functionButton("Initialize printer", () { _initPrinter(); } ),
      _functionButton("Get printer status", () { _getPrinterStatus(); } ), 
      _functionButton("Reset printer", () { _reset(); } ),

      _functionButton("Set font bold", () { _setFontBold(); } ),
      _functionButton("Set font size", () { _setFontSize(); } ), 
      _functionButton("Set font alignment", () { _setFontAlignment(1); } ),
      _functionButton("Set font row height", () { _setFountRowHeight(); } ),

      _functionButton("Print text", () { _printText(); } ), 
      _functionButton("Print image", () { _printImage(); } ), 
      _functionButton("Print qrcode", () { _printQRCode(); } ), 
      _functionButton("Print barcode", () { _printBarcode(); } ), 
      _functionButton("Print table", () { _printTable(); } ), 
      _functionButton("Print line", () { _printLine(); } ), 

      _functionButton("Enter printer buffer", () { _enterPrinterBuffer(); } ), 
      _functionButton("Exit printer buffer", () { _exitPrinterBuffer(); } ),
      const SizedBox(height: 8),
    ];
    var column = Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
    return SingleChildScrollView(child: column);
  }

  _onSuccessCallback(value) {
    Fluttertoast.showToast(msg: value);
  }

  _onErrorCallback(e) {
    print(e);
    var string = e.toString();
    Fluttertoast.showToast(msg: string);
  }

  _initPrinter() {
    PrinterEngine.initPrinter().then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _getPrinterStatus() {
    onSuccess(value) => {
      Fluttertoast.showToast(msg: "status: $value")
    };
    PrinterEngine.getPrinterStatus().then(onSuccess).catchError(_onErrorCallback);
  }

  _reset() {
    PrinterEngine.reset().then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _setFontBold() {
    PrinterEngine.setBold(true).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _setFontSize() {
    PrinterEngine.setFontSize(32).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _setFontAlignment(int alignment) {
    PrinterEngine.setAlignment(alignment).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _setFountRowHeight() {
    PrinterEngine.setRowHeight(40).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _printText() {
    PrinterEngine.printText("I believe there is a person who brings sunshine into your life. That person may have enough to spread around. But if you really have to wait for someone to bring you the sun and give you a good feeling, then you may have to wait a long time.\n",)
      .then(_onSuccessCallback)
      .catchError(_onErrorCallback);
  }

  _printImage() {
    onSuccess(value) => {
      PrinterEngine.printImage(value).then(_onSuccessCallback).catchError(_onErrorCallback)
    };
    image2Bytes("images/printer.png").then(onSuccess);
  }

  _printBarcode() {
    PrinterEngine.printBarcode("0123456789123", 8, 162, 2, 2).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _printQRCode() {
    _setFontAlignment(1);
    PrinterEngine.printQRCode("0123456789123", 8, 3).then(_onSuccessCallback).catchError(_onErrorCallback);
    _setFontAlignment(2);
  }

  _printTable() {
    var columnText = ["Green Tea", "1", "4000"];
    var columnWidth = [2, 1, 1];
    var columnAlign = [1, 0, 2];
    PrinterEngine.printTable(columnText, columnWidth, columnAlign).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _printLine() {
    PrinterEngine.printLine(6).then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  _enterPrinterBuffer() {
    PrinterEngine.enterPrinterBuffer();
  }

  _exitPrinterBuffer() {
    PrinterEngine.exitPrinterBuffer().then(_onSuccessCallback).catchError(_onErrorCallback);
  }

  static Future<Uint8List> image2Bytes(String path) async {
    var byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  }

  Widget _functionButton(String data, VoidCallback onPressed) {
    var padding = const EdgeInsets.only(left: 16, right: 16, bottom: 8);
    var style = const TextStyle(color: Colors.white, fontSize: 16);
    var text = Text(data, style: style);
    var button = MaterialButton(onPressed: onPressed, color: Colors.blueAccent, child: text);
    return Container(height: 64, width: double.infinity, padding: padding, child: button);
  }

}