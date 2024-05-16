import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/scanner_engine.dart';
import 'package:sun_mi_flutter_sdk/pages/base_state.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateful_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';

class ScannerPage extends BaseStatelessWidget {

  const ScannerPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Scanner";

  @override
  Widget onCreateChild(BuildContext context) => const _ScannerWidget();

}

class _ScannerWidget extends BaseStatefulWidget {

  const _ScannerWidget( { Key ? key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerState();

}

class _ScannerState extends BaseState<_ScannerWidget> {

  String _type = "";
  String _value = "";

  @override
  Widget build(BuildContext context) {
    startScanAction() => _startScan();
    var textStyle = const TextStyle(color: Colors.white, fontSize: 14);
    var text = Text("Start Scan", style: textStyle);
    var button = MaterialButton(onPressed: startScanAction, color: Colors.blueAccent, child: text);

    var style = const TextStyle(color: Colors.black, fontSize: 14);
    List<Widget> children = [
      button, const SizedBox(height: 8),
      Text("Type: $_type", style: style), const SizedBox(height: 4),
      Text("Value: $_value", style: style),
    ];
    var column = Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
    return Container(margin: const EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
  }

  _startScan() {
    Map value = {};
    callback() => _update(value);
    onSuccess(map) {
      value = map;
      setState(callback);
    }
    ScanEngine.startScan().then(onSuccess);
  }

  _update(Map map) {
    _type = map['type'];
    _value = map['value'];
  }

}