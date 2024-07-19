import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_buzzer_page.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_get_system_parameter_page.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_screen_exclusive_page.dart';
import 'package:sun_mi_flutter_sdk/utils/navigator_util.dart';
import 'package:sun_mi_flutter_sdk/widget/common_ui.dart';

class BasicPage extends BaseStatelessWidget {

  const BasicPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Basic";

  @override
  Widget onCreateChild(BuildContext context) {
    emptyAction() => {};
    gotoBuzzerPageAction() => _gotoBuzzerPage(context);
    gotoScreenExclusivePageAction() => _gotoScreenExclusivePage(context);
    gotoGetSystemParameterPageAction() => _gotoGetSystemParameterPage(context);

    List<Widget> children = [
      CommonUiUtil.commonItem("Get System Parameters", true, gotoGetSystemParameterPageAction),
      CommonUiUtil.commonItem("Buzzer", true, gotoBuzzerPageAction),
      CommonUiUtil.commonItem("LED Lamp Control", true, emptyAction),
      CommonUiUtil.commonItem("Set Screen Exclusive", true, gotoScreenExclusivePageAction),
    ];
    return Column(children: children);
  }

  _gotoBuzzerPage(context) {
    builder(context) => const BasicBuzzerPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gotoGetSystemParameterPage(context) {
    builder(context) => const BasicGetSystemParameterPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gotoScreenExclusivePage(context) {
    builder(context) => const BasicScreenExclusivePage();
    NavigatorUtil.navigation(context, builder);
  }

}
