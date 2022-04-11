import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/GetSystemParameterPage.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/ScreenExclusivePage.dart';
import 'package:sun_mi_flutter_sdk/widget/WidgetHelper.dart';

class BasicPage extends StatelessWidget {

  const BasicPage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic'), ),
      body: _mainView(context),
    );
  }

  _mainView(BuildContext context) {
    return Column(
      children: [
        WidgetHelper.itemWidget("Get system parameters", true, () { _gotoGetSystemParameterPage(context); } ),
        WidgetHelper.itemWidget("Buzzer", true, () { } ),
        WidgetHelper.itemWidget("LED lamp control", true, () { } ),
        WidgetHelper.itemWidget("Set screen exclusive", true, () {  _gotoScreenExclusivePage(context); } ),
      ],
    );
  }

  _gotoGetSystemParameterPage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const GetSystemParameterPage(), )
    );
  }

  _gotoScreenExclusivePage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ScreenExclusivePage(), )
    );
  }

}