import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

import 'BasicPage.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen( { Key ? key } ) : super(key: key);

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
                  _tabItem('Print', ColorHelper.print, () {  } ),
                ]
            ),
            Row(
                children:[
                  _tabItem('Scan', ColorHelper.security, () {}),
                  _tabItem('Emv', ColorHelper.emv, () {}),
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