import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/entity/card_info.dart';
import 'package:sun_mi_flutter_sdk/pages/base_state.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateful_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/card/card_ui_util.dart';
import 'package:sun_mi_flutter_sdk/utils/string_util.dart';

class ChipCardTestPage extends BaseStatelessWidget {

  const ChipCardTestPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "IC Card Test";

  @override
  Widget onCreateChild(BuildContext context) => const _ChipCardWidget();

}

class _ChipCardWidget extends BaseStatefulWidget {

  const _ChipCardWidget( { Key ? key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChipCardState();

}

class _ChipCardState extends BaseState<_ChipCardWidget> {

  int _totalTime = 0;
  int _failedTime = 0;
  int _successTime = 0;
  CardInfo ? _cardInfo;

  @override
  Widget build(BuildContext context) {
    var info = CardInfo();
    if (_cardInfo != null) info = _cardInfo!;
    var atr = StringUtil.null2String(info.atr);

    var image = Image.asset("images/card_ic.png", width: 560);
    List<Widget> childs = [
      CardUiUtil.summaryText("Total: $_totalTime"), const SizedBox(width: 8),
      CardUiUtil.summaryText("Pass: $_successTime"), const SizedBox(width: 8),
      CardUiUtil.summaryText("Fail: $_failedTime"),
    ];
    List<Widget> children = [
      const SizedBox(height: 24), image,
      const SizedBox(height: 16), Row(children: childs),
      const SizedBox(height: 16), CardUiUtil.itemText("ATR: $atr"),
      const SizedBox(height: 24),
    ];
    var column = Column(children: children, crossAxisAlignment: CrossAxisAlignment.start);
    var container = Container(padding: const EdgeInsets.only(left: 16, right: 16), child: column);
    return container;
  }

}
