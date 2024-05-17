import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseStatelessWidget extends StatelessWidget {

  const BaseStatelessWidget( {  Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: Colors.white, fontSize: 18);
    var titleString = getTitleString();
    var text = Text(titleString, style: style);
    var iconThemeData = const IconThemeData(color: Colors.white);
    var appBar = AppBar(title: text, iconTheme: iconThemeData, backgroundColor: Colors.blue);
    var body = onCreateChild(context);
    return Scaffold(appBar: appBar, body: body);
  }

  Widget onCreateChild(BuildContext context);

  String getTitleString() {
    return "";
  }

  showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  onError(e) {
    debugPrint(e);
    var string = e.toString();
    showToast(string);
  }

}
