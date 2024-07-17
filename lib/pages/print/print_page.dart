import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/printer_engine.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/widget/common_ui.dart';

class PrintPage extends BaseStatelessWidget {

  const PrintPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Print";

  @override
  onCreateChild(BuildContext context) {
    PrinterEngine.initPrinter();

    printRowAction() => _printRow();
    printTextAction() => _printText();
    printImageAction() => _printImage();
    printBufferAction() => _printBuffer();
    getPrinterStatusAction() => _getPrinterStatus();
    printBarcodeAndQRCodeAction() => _printBarcodeAndQRCode();

    List<Widget> children = [
      CommonUiUtil.commonItem("Get printer status", true, getPrinterStatusAction),
      CommonUiUtil.commonItem("Print text", true, printTextAction),
      CommonUiUtil.commonItem("Print image", true, printImageAction),
      CommonUiUtil.commonItem("Print row", true, printRowAction),
      CommonUiUtil.commonItem("Print barcode and qrcode", true, printBarcodeAndQRCodeAction),
      CommonUiUtil.commonItem("Print buffer", true, printBufferAction),
    ];
    return Column(children: children);
  }

  _onSuccessCallback(value) {
    showToast(value);
  }

  _getPrinterStatus() {
    onSuccess(value) => showToast("status: $value");
    PrinterEngine.getPrinterStatus().then(onSuccess).catchError(onError);
  }

  _printText() {
    PrinterEngine.reset();
    PrinterEngine.printText(
      "I believe there is a person who brings sunshine into your life. That person may have enough to spread around. But if you really have to wait for someone to bring you the sun and give you a good feeling, then you may have to wait a long time.\n",
    ).then(_onSuccessCallback).catchError(onError);

    PrinterEngine.setFontSize(28);
    PrinterEngine.setFontBold(true);
    PrinterEngine.setFontAlignment(1);
    PrinterEngine.printText("Hello, PayBy Team!");
    PrinterEngine.printLine(6);
  }

  _printImage() {
    PrinterEngine.reset();
    onSuccess(value) => PrinterEngine.printImage(value).then(_onSuccessCallback).catchError(onError);
    _image2Bytes("images/printer.png").then(onSuccess).catchError(onError);
    PrinterEngine.printLine(6);
  }

  _printRow() {
    var columnWidth = [2, 1, 1];
    var columnAlign = [1, 0, 2];
    var columnText = ["Green Tea", "1", "4000"];
    PrinterEngine.reset();
    PrinterEngine.printTable(columnText, columnWidth, columnAlign).then(_onSuccessCallback).catchError(onError);

    PrinterEngine.setFontSize(20);
    PrinterEngine.setFontBold(true);
    columnWidth = [1, 1, 1];
    columnAlign = [0, 0, 0];
    PrinterEngine.printTable(columnText, columnWidth, columnAlign);
    PrinterEngine.printLine(6);
  }

  _printBarcodeAndQRCode() {
    PrinterEngine.reset();
    PrinterEngine.printBarcode("0123456789123", 8, 162, 2, 2).then(_onSuccessCallback).catchError(onError);
    PrinterEngine.printLine(2);

    PrinterEngine.setFontAlignment(1);
    PrinterEngine.printQRCode("0123456789123", 8, 3);
    PrinterEngine.printLine(2);

    PrinterEngine.setFontAlignment(0);
    PrinterEngine.printQRCode("0123456789123", 6, 2);
    PrinterEngine.printLine(6);
  }

  _printBuffer() {
    PrinterEngine.reset();
    PrinterEngine.enterPrinterBuffer();

    PrinterEngine.setFontSize(28);
    PrinterEngine.setFontBold(true);
    PrinterEngine.setFontAlignment(1);
    PrinterEngine.printText("Hello, PayBy Team!");

    PrinterEngine.setFontSize(20);
    PrinterEngine.setFontBold(false);
    PrinterEngine.setFontAlignment(0);
    PrinterEngine.printText("I believe there is a person who brings sunshine into your life. That person may have enough to spread around.");

    onSuccess(value) => PrinterEngine.printImage(value);
    _image2Bytes("images/printer.png").then(onSuccess);

    PrinterEngine.printBarcode("0123456789123", 8, 162, 2, 2);

    PrinterEngine.printLine(6);
    PrinterEngine.exitPrinterBuffer().then(_onSuccessCallback).catchError(onError);
  }

  static Future<Uint8List> _image2Bytes(String path) async {
    var byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    // var bytes = byteData.buffer.asUint8List();
    // return base64Encode(bytes);
  }

}
