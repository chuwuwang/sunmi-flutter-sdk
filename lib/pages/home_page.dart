import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_page.dart';
import 'package:sun_mi_flutter_sdk/pages/card/card_page.dart';
import 'package:sun_mi_flutter_sdk/pages/print/print_page.dart';
import 'package:sun_mi_flutter_sdk/pages/scanner/scanner_page.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';
import 'package:sun_mi_flutter_sdk/utils/navigator_util.dart';

class HomePage extends StatelessWidget {

  const HomePage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    var text = Text("SUN" + "MI Flutter SDK", style: style);
    var appBar = AppBar(title: text, backgroundColor: Colors.blue);
    var body = _mainView(context);
    var scaffold = Scaffold(appBar: appBar, body: body);
    return MaterialApp(home: scaffold);
  }

  _mainView(BuildContext context) {
    emptyAction() => {};
    gotoPrintPageAction() => _gtoPrintPage(context);
    gotoBasicPageAction() => _gotoBasicPage(context);
    gotoScannerPageAction() => _gotoScannerPage(context);

    gotoEmvPageAction() => _gotoEmvPage(context);
    gotoPinPadPageAction() => _gotoPinPadPage(context);
    gtoReadCardPageAction() => _gotoReadCardPage(context);
    gotoSecurityPageAction() => _gotoSecurityPage(context);

    List<Widget> children1st = [
      _tabItem("Basic", ColorHelper.greenColor, gotoBasicPageAction),
      _tabItem("ReadCard", ColorHelper.blueColor, gtoReadCardPageAction),
    ];
    List<Widget> children2nd = [
      _tabItem("Security", ColorHelper.yellowColor, gotoSecurityPageAction),
      _tabItem("PinPad", ColorHelper.greyColor, gotoPinPadPageAction),
    ];
    List<Widget> children3td = [
      _tabItem("EMV", ColorHelper.orangeColor, gotoEmvPageAction),
      _tabItem("Scanner", ColorHelper.greenColor, gotoScannerPageAction),
    ];
    List<Widget> children4th = [
      _tabItem("Print", ColorHelper.blueColor, gotoPrintPageAction),
      _tabItem("", Colors.white, emptyAction),
    ];
    var row1st = Row(children: children1st);
    var row2nd = Row(children: children2nd);
    var row3td = Row(children: children3td);
    var row4th = Row(children: children4th);
    List<Widget> children = [row1st, row2nd, row3td, row4th];
    var column = Column(children: children);
    var container = Container(padding: const EdgeInsets.all(8), child: column);
    return SingleChildScrollView(child: container);
  }

  _gotoBasicPage(context) {
    builder(context) => const BasicPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gtoPrintPage(context) {
    builder(context) => const PrintPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gotoScannerPage(context) {
    builder(context) => const ScannerPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gotoEmvPage(context) {

  }

  _gotoPinPadPage(context) {

  }

  _gotoSecurityPage(context) {

  }

  _gotoReadCardPage(context) {
    builder(context) => const ReadCardPage();
    NavigatorUtil.navigation(context, builder);
  }

  _tabItem(String text, Color color, VoidCallback onPressed) {
    var borderRadius = BorderRadius.circular(8);
    var roundedRectangleBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    var textStyle = const TextStyle(color: Colors.white, fontSize: 18);
    MaterialButton button;
    if (text.isEmpty) {
      button = MaterialButton(color: color, onPressed: onPressed, child: Text(text, style: textStyle), shape: roundedRectangleBorder, elevation: 0);
    } else {
      button = MaterialButton(color: color, onPressed: onPressed, child: Text(text, style: textStyle), shape: roundedRectangleBorder);
    }
    var container = Container(height: 112, margin: const EdgeInsets.fromLTRB(4, 4, 4, 4), child: button);
    return Expanded(flex: 1, child: container);
  }

}
