import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/plugins/TestChannel.dart';

class GetSysParamScreen extends StatelessWidget {

  const GetSysParamScreen( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get System Parameters'), ),
      body: _mainView(context),
    );
  }

  _mainView(BuildContext context) {
    TestPlugin.getSystemParameters().then( (value) => {
          print("value: $value")
      }
    );
  }

}