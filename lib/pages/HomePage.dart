import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/print/PrintPage.dart';
import 'package:sun_mi_flutter_sdk/pages/scan/ScanPage.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

import 'basic/BasicPage.dart';

class HomePage extends StatelessWidget {

  const HomePage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('S U N M I Flutter Sdk'), ),
        body: _mainView(context),
      ),
    );
  }

  _mainView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
                children:[
                  _tabItem('Basic', ColorHelper.basic, () { _gotoBasicPage(context); } ),
                  _tabItem('Print', ColorHelper.print, () { _gtoPrintPage(context); } ),
                ]
            ),
            Row(
                children:[
                  _tabItem('Scan', ColorHelper.security, () { _gotoScanPage(context); } ),
                  _tabItem('Emv', ColorHelper.emv, () { } ),
                ]
            )
          ],
        ),
      ),
    );
  }

  _gotoBasicPage(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const BasicPage(), )
    );
  }

  _gtoPrintPage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const PrintPage(), )
    );
  }

  _gotoScanPage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ScanPage(), )
    );
  }

  _tabItem(String text, Color color, VoidCallback onPressed) {
    return Expanded(
        flex: 1,
        child: Container(
          height: 112,
          margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          child: MaterialButton(
            color: color,
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18), ),
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8), ),
          ),
        )
    );
  }

}