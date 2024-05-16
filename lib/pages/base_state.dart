// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  onError(e) {
    print(e);
    var string = e.toString();
    showToast(string);
  }

}