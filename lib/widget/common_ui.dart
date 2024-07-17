import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

class CommonUiUtil {

  static commonItem(String text, bool isIcon, VoidCallback onPressed) {
    var style = const TextStyle(color: ColorHelper.textContentColor, fontSize: 14);
    var leftText = Text(text, style: style);
    var expanded = Expanded(child: leftText);
    var icon = const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black26);
    var children = [expanded, if (isIcon) icon];
    var row = Row(children: children);
    var container = Container(height: 50, padding: const EdgeInsets.only(left: 16, right: 16), child: row);
    var divider = const Divider(height: 1, color: ColorHelper.defaultLineColor);
    var containerLine = Container(margin: const EdgeInsets.fromLTRB(0, 49, 0, 0), child: divider);
    var childrenStack = [container, containerLine];
    var stack = Stack(children:childrenStack);
    return MaterialButton(padding: EdgeInsets.zero, onPressed: onPressed, child: stack,);
  }

  static backgroundWhiteRadius(double rd) {
    var radius = Radius.circular(rd);
    var borderRadius = BorderRadius.all(radius);
    var border = Border.all(color: ColorHelper.defaultLineColor, width: 1);
    return BoxDecoration(border: border, color: Colors.white, borderRadius: borderRadius);
  }

}