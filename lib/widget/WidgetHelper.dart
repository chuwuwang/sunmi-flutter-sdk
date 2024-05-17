import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

class WidgetHelper {

  static itemWidget(String text, bool rightIcon, VoidCallback onPressed) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Stack(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: [
                Expanded(child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 16), ), ),
                if (rightIcon) const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 55, 0, 0),
            child: const Divider(height: 1, color: Colors.black26),
          )
        ],
      ),
    );
  }

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

}