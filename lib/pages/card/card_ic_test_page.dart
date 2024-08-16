import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/check_card_processor_engine.dart';
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
  String _description = "IC Card Test";

  @override
  void initState() {
    super.initState();
    _startCheckCard();
  }

  @override
  void dispose() {
    super.dispose();
    CheckCardProcessorEngine.stopCheckCard();
  }

  @override
  Widget build(BuildContext context) {
    var info = CardInfo();
    if (_cardInfo != null) info = _cardInfo ! ;
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
      const SizedBox(height: 16), CardUiUtil.descriptionText(_description),
      const SizedBox(height: 8), CardUiUtil.itemText("ATR: $atr"),
      const SizedBox(height: 24),
    ];
    var column = Column(children: children, crossAxisAlignment: CrossAxisAlignment.start);
    var container = Container(padding: const EdgeInsets.only(left: 16, right: 16), child: column);
    return container;
  }

  void _startCheckCard() {
    var future = CheckCardProcessorEngine.startCheckCard(2, 60);
    future.then(_onCheckCardSuccess).catchError(_onCheckCardFailure);
  }

  void _onCheckCardSuccess(value) {
    _totalTime++;
    _successTime++;
    callback() {
      var obj = jsonDecode(value);
      _description = "Find RF card";
      _cardInfo = CardInfo.fromJson(obj);
    }
    setState(callback);
    Future.delayed(const Duration(milliseconds: 500), _startCheckCard);
  }

  void _onCheckCardFailure(throwable) {
    _totalTime++;
    _failedTime++;
    callback() {
      _cardInfo = null;
      _description = "Check card error";
    }
    setState(callback);
    Future.delayed(const Duration(milliseconds: 500), _startCheckCard);
  }

}
