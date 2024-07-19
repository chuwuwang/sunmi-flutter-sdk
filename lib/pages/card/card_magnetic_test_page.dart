import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/entity/card_info.dart';
import 'package:sun_mi_flutter_sdk/pages/base_state.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateful_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/card/card_ui_util.dart';
import 'package:sun_mi_flutter_sdk/utils/string_util.dart';

class MagneticCardTestPage extends BaseStatelessWidget {

  const MagneticCardTestPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Magnetic Card Test";

  @override
  Widget onCreateChild(BuildContext context) => const _MagneticCardWidget();

}

class _MagneticCardWidget extends BaseStatefulWidget {

  const _MagneticCardWidget( { Key ? key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MagneticCardState();

}

class _MagneticCardState extends BaseState<_MagneticCardWidget> {

  int _totalTime = 0;
  int _failedTime = 0;
  int _successTime = 0;
  CardInfo ? _cardInfo;

  @override
  Widget build(BuildContext context) {
    var info = CardInfo();
    if (_cardInfo != null) info = _cardInfo!;
    var track1 = StringUtil.null2String(info.track1);
    var track2 = StringUtil.null2String(info.track2);
    var track3 = StringUtil.null2String(info.track3);
    var cardNumber = StringUtil.null2String(info.cardNumber);
    var expireDate = StringUtil.null2String(info.expireDate);
    var serviceCode = StringUtil.null2String(info.serviceCode);
    var cardholderName = StringUtil.null2String(info.cardholderName);
    var cardSerialNumber = StringUtil.null2String(info.cardSerialNumber);

    var image = Image.asset("images/card_magnetic.png", width: 560);
    List<Widget> childs = [
      CardUiUtil.summaryText("Total: $_totalTime"), const SizedBox(width: 8),
      CardUiUtil.summaryText("Pass: $_successTime"), const SizedBox(width: 8),
      CardUiUtil.summaryText("Fail: $_failedTime"),
    ];
    List<Widget> children = [
      const SizedBox(height: 24), image,
      const SizedBox(height: 16), Row(children: childs),
      const SizedBox(height: 16), CardUiUtil.itemText("Track1: $track1"),
      const SizedBox(height: 8), CardUiUtil.itemText("Track2: $track2"),
      const SizedBox(height: 8), CardUiUtil.itemText("Track3: $track3"),
      const SizedBox(height: 8), CardUiUtil.itemText("PAN: $cardNumber"),
      const SizedBox(height: 8), CardUiUtil.itemText("Cardholder Name: $cardholderName"),
      const SizedBox(height: 8), CardUiUtil.itemText("Expire Date: $expireDate"),
      const SizedBox(height: 8), CardUiUtil.itemText("Service Code: $serviceCode"),
      const SizedBox(height: 8), CardUiUtil.itemText("Serial Number: $cardSerialNumber"),
      const SizedBox(height: 24),
    ];
    var column = Column(children: children, crossAxisAlignment: CrossAxisAlignment.start);
    var container = Container(padding: const EdgeInsets.only(left: 16, right: 16), child: column);
    return container;
  }

}
