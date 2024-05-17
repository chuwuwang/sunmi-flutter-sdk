import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseStatelessWidget extends StatelessWidget {

  const BaseStatelessWidget( {  Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleString = getTitleString();
    var text = Text(titleString);
    var appBar = AppBar(title: text);
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
