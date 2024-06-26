import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_buzzer_page.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_get_system_parameter_page.dart';
import 'package:sun_mi_flutter_sdk/pages/basic/basic_screen_exclusive_page.dart';
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
      CommonUiUtil.commonItem("Get system parameters", true, gotoGetSystemParameterPageAction),
      CommonUiUtil.commonItem("Buzzer", true, gotoBuzzerPageAction),
      CommonUiUtil.commonItem("LED lamp control", true, emptyAction),
      CommonUiUtil.commonItem("Set screen exclusive", true, gotoScreenExclusivePageAction),
    ];
    return Column(children: children);
  }

  _gotoBuzzerPage(context) {
    builder(context) => const BasicBuzzerPage();
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

  _gotoGetSystemParameterPage(context) {
    builder(context) => const BasicGetSystemParameterPage();
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

  _gotoScreenExclusivePage(context) {
    builder(context) => const BasicScreenExclusivePage();
    var route = MaterialPageRoute(builder: builder);
    Navigator.of(context).push(route);
  }

}
