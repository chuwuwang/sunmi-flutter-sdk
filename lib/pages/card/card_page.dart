import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/card/card_ic_test_page.dart';
import 'package:sun_mi_flutter_sdk/pages/card/card_magnetic_test_page.dart';
import 'package:sun_mi_flutter_sdk/pages/card/card_nfc_test_page.dart';
import 'package:sun_mi_flutter_sdk/utils/navigator_util.dart';
import 'package:sun_mi_flutter_sdk/widget/common_ui.dart';

class ReadCardPage extends BaseStatelessWidget {

  const ReadCardPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Read Card";

  @override
  Widget onCreateChild(BuildContext context) {
    emptyAction() => {};
    gotoChipCardTestPageAction() => _gotoChipCardTestPage(context);
    gotoNFCCardTestPageAction() => _gotoNFCCardTestPage(context);
    gotoMagneticCardTestPageAction() => _gotoMagneticCardTestPage(context);

    List<Widget> children = [
      CommonUiUtil.commonItem("Magnetic Card Test", true, gotoMagneticCardTestPageAction),
      CommonUiUtil.commonItem("IC Card Test", true, gotoChipCardTestPageAction),
      CommonUiUtil.commonItem("NFC Card Test", true, gotoNFCCardTestPageAction),
      CommonUiUtil.commonItem("Mifare Card Test", true, emptyAction),
      CommonUiUtil.commonItem("Normal APDU Test", true, emptyAction),
      CommonUiUtil.commonItem("Transmit APDU Test", true, emptyAction),
    ];
    return Column(children: children);
  }

  _gotoMagneticCardTestPage(context) {
    builder(context) => const MagneticCardTestPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gotoChipCardTestPage(context) {
    builder(context) => const ChipCardTestPage();
    NavigatorUtil.navigation(context, builder);
  }

  _gotoNFCCardTestPage(context) {
    builder(context) => const NFCCardTestPage();
    NavigatorUtil.navigation(context, builder);
  }

}
