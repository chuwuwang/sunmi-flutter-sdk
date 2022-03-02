import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/GetSysParamScreen.dart';
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
        WidgetHelper.itemWidget("Get system parameters", () { _gotoGetSysParamScreen(context); } ),
        WidgetHelper.itemWidget("Buzzer", () { } ),
        WidgetHelper.itemWidget("LED lamp control", () { } ),
        WidgetHelper.itemWidget("Set screen exclusive", () { } ),
      ],
    );
  }

  _gotoGetSysParamScreen(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const GetSysParamScreen(), )
    );
  }

}