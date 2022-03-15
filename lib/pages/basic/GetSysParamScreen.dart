import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/plugins/DeviceInfoEngine.dart';

class GetSysParamScreen extends StatelessWidget {

  const GetSysParamScreen( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get System Parameters'), ),
      body: const DeviceInfoWidget(),
    );
  }

}

class DeviceInfoWidget extends StatefulWidget {

  const DeviceInfoWidget( { Key ? key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DeviceInfoState();
  }

}

class DeviceInfoState extends State<DeviceInfoWidget> {

  String _deviceCode = "";
  String _deviceModel = "";
  String _deviceBrand = "";
  String _serialNumber = "";
  String _systemVersionName = "";
  String _systemVersionCode = "";
  String _PN = "";
  String _TUSN = "";
  String _firmwareVersion = "";
  String _hardwareVersion = "";
  String _debugMode = "";

  @override
  void initState() {
    super.initState();
    var list = [
      "deviceCode",
      "deviceModel",
      "deviceBrand",
      "serialNumber",
      "systemVersionName",
      "systemVersionCode",
      "PN",
      "terminalUniqueSerialNumber",
      "firmwareVersion",
      "hardwareVersion",
      "debugMode"
    ];
    _getSerialNumber();
  }

  _getSerialNumber() {
    DeviceInfoEngine.getSystemParameters("serialNumber").then( (value) => {
          setState( () { _serialNumber = value; } )
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Column(
        children: [
          _textWidget("SerialNumber: $_serialNumber"),
        ],
      ),
    );
  }

  _textWidget(String text) {
    return Text(text, style: const TextStyle(color: Colors.black, fontSize: 14), );
  }

}