import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/device_info_engine.dart';
import 'package:sun_mi_flutter_sdk/pages/base_state.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateful_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

class BasicBuzzerPage extends BaseStatelessWidget {

  const BasicBuzzerPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Buzzer";

  @override
  Widget onCreateChild(BuildContext context) => const _BuzzerWidget();

}

class _BuzzerWidget extends BaseStatefulWidget {

  const _BuzzerWidget( { Key ? key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BuzzerState();

}

class _BuzzerState extends BaseState<_BuzzerWidget> {

  final _controller = TextEditingController();
  var _groupValue = "3 time";

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(color: ColorHelper.textContentColor, fontSize: 14, height: 1.6);
    var inputDecoration = InputDecoration(hintText: "delay time (200~10000 ms), default 500 ms", hintStyle: textStyle);
    var textField = TextField(controller: _controller, keyboardType: TextInputType.number, decoration: inputDecoration);
    var text = Text("Buzzer Time", style: textStyle, textAlign: TextAlign.start);
    onChanged(value) {
      callback() => _groupValue = value;
      setState(callback);
      var delay = 500;
      var delayString = _controller.text.toString();
      if (delayString.isNotEmpty) {
        delay = int.parse(delayString);
      }
      if (delay < 200 || delay > 10000) {
        showToast("Please input correct delay time");
        return;
      }
      var substring = _groupValue.substring(0, 1);
      var time = int.parse(substring);
      DeviceInfoEngine.buzzer(time, delay);
    }
    var radioButton1st = _radioButton("1 time", onChanged);
    var radioButton2nd = _radioButton("2 time", onChanged);
    var radioButton3rd = _radioButton("3 time", onChanged);
    var radioButton4th = _radioButton("4 time", onChanged);
    var radioButton5th = _radioButton("5 time", onChanged);
    var radioButton6th = _radioButton("6 time", onChanged);
    var children = [
      textField, const SizedBox(height: 16), text,
      radioButton1st, radioButton2nd, radioButton3rd,
      radioButton4th, radioButton5th, radioButton6th,
    ];
    var column = Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
    var container = Container(margin: const EdgeInsets.all(16), child: column);
    return SingleChildScrollView(child: container);
  }

  Widget _radioButton(String value, ValueChanged onChanged) {
    var textStyle = const TextStyle(color: ColorHelper.textMainColor, fontSize: 14);
    var radio = Radio(value: value, groupValue: _groupValue, onChanged: onChanged);
    var text = Text(value, style: textStyle, textAlign: TextAlign.start);
    var children = [radio, text];
    return Row(children: children);
  }

}
