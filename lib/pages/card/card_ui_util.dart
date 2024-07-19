import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';
import 'package:sun_mi_flutter_sdk/widget/common_ui.dart';

class CardUiUtil {

  static Widget itemText(String data) {
    var style = const TextStyle(color: ColorHelper.textMainColor, fontSize: 16, fontWeight: FontWeight.bold);
    return Text(data, style: style);
  }

  static Widget summaryText(String data) {
    var style = const TextStyle(color: ColorHelper.textContentColor, fontSize: 14);
    var text = Text(data, style: style);
    var boxDecoration = CommonUiUtil.backgroundWhiteRadius(0);
    var container = Container(height: 40, decoration: boxDecoration, alignment: Alignment.center, child: text);
    return Expanded(child: container);
  }

}
