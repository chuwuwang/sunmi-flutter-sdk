import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sun_mi_flutter_sdk/pages/home_page.dart';

void main() {
  if (Platform.isAndroid) {
    var style = const SystemUiOverlayStyle(statusBarColor: Colors.blue);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  var app = const MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {

  const MyApp( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var home = const HomePage();
    var theme = ThemeData(primarySwatch: Colors.blue);
    return MaterialApp(title: "Flutter Demo", theme: theme, home: home);
  }

}
