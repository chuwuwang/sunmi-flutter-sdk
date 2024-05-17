import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/printer_engine.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';

class PrintPage extends BaseStatelessWidget {

  const PrintPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Print";

  @override
  onCreateChild(BuildContext context) {
    initPrinterAction() => _initPrinter();
    getPrinterStatusAction() => _getPrinterStatus();
    resetAction() => _reset();

    setFontBoldAction() => _setFontBold();
    setFontSizeAction() => _setFontSize();
    setFontRowHeightAction() => _setFontRowHeight();
    setFontAlignmentAction() => _setFontAlignment(1);

    printTextAction() => _printText();
    printImageAction() => _printImage();
    printQRCodeAction() => _printQRCode();
    printBarcodeAction() => _printBarcode();
    printTableAction() => _printTable();
    printLineAction() => _printLine();

    enterPrinterBufferAction() => _enterPrinterBuffer();
    exitPrinterBufferAction() => _exitPrinterBuffer();

    List<Widget> children = [
      const SizedBox(height: 16),
      _functionButton("Initialize printer", initPrinterAction),
      _functionButton("Get printer status", getPrinterStatusAction),
      _functionButton("Reset printer", resetAction),

      _functionButton("Set font bold", setFontBoldAction),
      _functionButton("Set font size", setFontSizeAction),
      _functionButton("Set font alignment", setFontAlignmentAction),
      _functionButton("Set font row height", setFontRowHeightAction),

      _functionButton("Print text", printTextAction),
      _functionButton("Print image", printImageAction),
      _functionButton("Print qrcode", printQRCodeAction),
      _functionButton("Print barcode", printBarcodeAction),
      _functionButton("Print table", printTableAction),
      _functionButton("Print line", printLineAction),

      _functionButton("Enter printer buffer", enterPrinterBufferAction),
      _functionButton("Exit printer buffer", exitPrinterBufferAction),
      const SizedBox(height: 8),
    ];
    var column = Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
    return SingleChildScrollView(child: column);
  }

  _onSuccessCallback(value) {
    showToast(value);
  }

  _initPrinter() {
    PrinterEngine.initPrinter().then(_onSuccessCallback).catchError(onError);
  }

  _getPrinterStatus() {
    onSuccess(value) => showToast("status: $value");
    PrinterEngine.getPrinterStatus().then(onSuccess).catchError(onError);
  }

  _reset() {
    PrinterEngine.reset().then(_onSuccessCallback).catchError(onError);
  }

  _setFontBold() {
    PrinterEngine.setFontBold(true).then(_onSuccessCallback).catchError(onError);
  }

  _setFontSize() {
    PrinterEngine.setFontSize(32).then(_onSuccessCallback).catchError(onError);
  }

  _setFontAlignment(int alignment) {
    PrinterEngine.setFontAlignment(alignment).then(_onSuccessCallback).catchError(onError);
  }

  _setFontRowHeight() {
    PrinterEngine.setFontRowHeight(40).then(_onSuccessCallback).catchError(onError);
  }

  _printText() {
    PrinterEngine.printText("I believe there is a person who brings sunshine into your life. That person may have enough to spread around. But if you really have to wait for someone to bring you the sun and give you a good feeling, then you may have to wait a long time.\n",)
      .then(_onSuccessCallback).catchError(onError);
  }

  _printImage() {
    onSuccess(value) => PrinterEngine.printImage(value).then(_onSuccessCallback).catchError(onError);
    _image2Bytes("images/printer.png").then(onSuccess);
  }

  _printBarcode() {
    PrinterEngine.printBarcode("0123456789123", 8, 162, 2, 2).then(_onSuccessCallback).catchError(onError);
  }

  _printQRCode() {
    _setFontAlignment(1);
    PrinterEngine.printQRCode("0123456789123", 8, 3).then(_onSuccessCallback).catchError(onError);
    _setFontAlignment(2);
  }

  _printTable() {
    var columnText = ["Green Tea", "1", "4000"];
    var columnWidth = [2, 1, 1];
    var columnAlign = [1, 0, 2];
    PrinterEngine.printTable(columnText, columnWidth, columnAlign).then(_onSuccessCallback).catchError(onError);
  }

  _printLine() {
    PrinterEngine.printLine(6).then(_onSuccessCallback).catchError(onError);
  }

  _enterPrinterBuffer() {
    PrinterEngine.enterPrinterBuffer();
  }

  _exitPrinterBuffer() {
    PrinterEngine.exitPrinterBuffer().then(_onSuccessCallback).catchError(onError);
  }

  static Future<Uint8List> _image2Bytes(String path) async {
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