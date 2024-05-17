import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  onError(e) {
    debugPrint(e);
    var string = e.toString();
    showToast(string);
  }

}
