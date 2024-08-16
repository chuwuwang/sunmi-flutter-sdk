import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/utils/toast_util.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  showToast(String message) {
    ToastUtil.showToast(message);
  }

  onError(e) {
    debugPrint(e);
    var string = e.toString();
    showToast(string);
  }

}
