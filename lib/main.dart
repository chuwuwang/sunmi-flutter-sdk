import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

void main() {
  var app = const MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {

  const MyApp( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('S U N M I Flutter Sdk'),
        ),
        body: _mainView(context),
      ),
    );
  }

}

_mainView(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
              children:[
                _tabItem('Basic', ColorHelper.basic, () {}),
                _tabItem('Print', ColorHelper.print, () {}),
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

_tabItem(String text, Color color, VoidCallback onPressed) {
  return Expanded(
      flex: 1,
      child: Container(
        height: 112,
        margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            )
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 18)
          ),
          color: color,
        ),
      )
  );
}
