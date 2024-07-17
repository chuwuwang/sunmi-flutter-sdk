import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/widget/common_ui.dart';

class ReadCardPage extends BaseStatelessWidget {

  const ReadCardPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Read Card";

  @override
  Widget onCreateChild(BuildContext context) {
    emptyAction() => {};

    List<Widget> children = [
      CommonUiUtil.commonItem("Magnetic card test", true, emptyAction),
      CommonUiUtil.commonItem("IC card test", true, emptyAction),
      CommonUiUtil.commonItem("NFC card test", true, emptyAction),
      CommonUiUtil.commonItem("Mifare card test", true, emptyAction),
      CommonUiUtil.commonItem("Normal APDU test", true, emptyAction),
      CommonUiUtil.commonItem("Transmit APDU test", true, emptyAction),
    ];
    return Column(children: children);
  }

}
