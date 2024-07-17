import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/entity/card_info.dart';
import 'package:sun_mi_flutter_sdk/pages/base_state.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateful_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';
import 'package:sun_mi_flutter_sdk/utils/string_util.dart';
import 'package:sun_mi_flutter_sdk/widget/common_ui.dart';

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
    var image = Image.asset("images/card_magnetic.png", width: 560);
    List<Widget> childs = [
      _summaryText("Total: $_totalTime"), const SizedBox(width: 8),
      _summaryText("Pass: $_successTime"), const SizedBox(width: 8),
      _summaryText("Fail: $_failedTime"),
    ];
    var track1 = StringUtil.null2String(_cardInfo?.track1);
    var track2 = StringUtil.null2String(_cardInfo?.track2);
    var track3 = StringUtil.null2String(_cardInfo?.track3);
    var cardNumber = StringUtil.null2String(_cardInfo?.cardNumber);
    var expireDate = StringUtil.null2String(_cardInfo?.expireDate);
    var serviceCode = StringUtil.null2String(_cardInfo?.serviceCode);
    var cardholderName = StringUtil.null2String(_cardInfo?.cardholderName);
    var cardSerialNumber = StringUtil.null2String(_cardInfo?.cardSerialNumber);

    List<Widget> children = [
      const SizedBox(height: 24), image,
      const SizedBox(height: 16), Row(children: childs),
      const SizedBox(height: 16), _itemText("Track1: $track1"),
      const SizedBox(height: 8), _itemText("Track2: $track2"),
      const SizedBox(height: 8), _itemText("Track3: $track3"),
      const SizedBox(height: 8), _itemText("PAN: $cardNumber"),
      const SizedBox(height: 8), _itemText("Cardholder Name: $cardholderName"),
      const SizedBox(height: 8), _itemText("Expire Date: $expireDate"),
      const SizedBox(height: 8), _itemText("Service Code: $serviceCode"),
      const SizedBox(height: 8), _itemText("Serial Number: $cardSerialNumber"),
      const SizedBox(height: 24),
    ];
    var column = Column(children: children, crossAxisAlignment: CrossAxisAlignment.start);
    var container = Container(padding: const EdgeInsets.only(left: 16, right: 16), child: column);
    return container;
  }

  Widget _itemText(String data) {
    var style = const TextStyle(color: ColorHelper.textMainColor, fontSize: 16, fontWeight: FontWeight.bold);
    return Text(data, style: style);
  }

  Widget _summaryText(String data) {
    var style = const TextStyle(color: ColorHelper.textContentColor, fontSize: 14);
    var text = Text(data, style: style);
    var boxDecoration = CommonUiUtil.backgroundWhiteRadius(0);
    var container = Container(height: 40, decoration: boxDecoration, alignment: Alignment.center, child: text);
    return Expanded(child: container);
  }

}
