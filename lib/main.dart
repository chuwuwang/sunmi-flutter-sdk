import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/printer_engine.dart';
import 'package:sun_mi_flutter_sdk/pages/home_page.dart';

void main() {
  if (Platform.isAndroid) {
    var style = const SystemUiOverlayStyle(statusBarColor: Colors.blue);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  var app = const MyApp();
  runApp(app);
  PrinterEngine.initPrinter();
}

class MyApp extends StatelessWidget {

  const MyApp( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var home = const HomePage();
    var colorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue, backgroundColor: Colors.white);
    var theme = ThemeData(primarySwatch: Colors.blue, colorScheme: colorScheme);
    return MaterialApp(title: "Flutter Demo", theme: theme, home: home);
  }

}
