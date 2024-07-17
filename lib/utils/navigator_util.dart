import 'package:flutter/material.dart';

class NavigatorUtil {

  static navigation(context, WidgetBuilder builder) {
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

}
