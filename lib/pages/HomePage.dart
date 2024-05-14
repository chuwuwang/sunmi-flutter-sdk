import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/BasicPage.dart';
import 'package:sun_mi_flutter_sdk/pages/print/PrintPage.dart';
import 'package:sun_mi_flutter_sdk/pages/scan/ScanPage.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

class HomePage extends StatelessWidget {

  const HomePage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = const Text('S U N M I Flutter SDK');
    var appBar = AppBar(title: text);
    var body = _mainView(context);
    var scaffold = Scaffold(appBar: appBar, body: body);
    return MaterialApp(home: scaffold);
  }

  _mainView(BuildContext context) {
    List<Widget> children1st = [
      _tabItem('Basic', ColorHelper.basic, () { _gotoBasicPage(context); } ),
      _tabItem('Print', ColorHelper.print, () { _gtoPrintPage(context); } ),
    ];
    List<Widget> children2nd = [
      _tabItem('Scan', ColorHelper.scan, () { _gotoScanPage(context); } ),
      _tabItem('Emv', ColorHelper.emv, () { _gtoPrintPage(context); } ),
    ];
    var row1st = Row(children: children1st);
    var row2nd = Row(children: children2nd);
    List<Widget> children = [row1st, row2nd];
    var column = Column(children: children);
    var container = Container(padding: const EdgeInsets.all(8), child: column);
    return SingleChildScrollView(child: container);
  }

  _gotoBasicPage(context) {
    builder(context) => const BasicPage();
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

  _gtoPrintPage(context) {
    builder(context) => const PrintPage();
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

  _gotoScanPage(context) {
    builder(context) => const ScanPage();
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

  _tabItem(String text, Color color, VoidCallback onPressed) {
    var borderRadius = BorderRadius.circular(8);
    var roundedRectangleBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    var textStyle = const TextStyle(color: Colors.white, fontSize: 18);
    var button = MaterialButton(color: color, onPressed: onPressed, child: Text(text, style: textStyle), shape: roundedRectangleBorder);
    var container = Container(height: 112, margin: const EdgeInsets.fromLTRB(4, 4, 4, 4), child: button);
    return Expanded(flex: 1, child: container);
  }

}