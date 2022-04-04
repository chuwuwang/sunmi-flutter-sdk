
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
  String _terminalUniqueSerialNumber = "";
  String _firmwareVersion = "";
  String _hardwareVersion = "";
  String _debugMode = "";
  String _reserved = "";
  String _supportETC = "";

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
      "debugMode",
      "reserved",
      "supportETC",
    ];
    for (var i = 0; i < list.length; i++) {
      var key = list[i];
      _getSystemParameters(key);
    }
  }

  _getSystemParameters(String key) {
    DeviceInfoEngine.getSystemParameters(key).then( (value) => {
        setState( () {
            switch(key) {
              case "deviceCode":
                _deviceCode = value;
                break;
              case "deviceModel":
                _deviceModel = value;
                break;
              case "deviceBrand":
                _deviceBrand = value;
                break;
              case "serialNumber":
                _serialNumber = value;
                break;
              case "systemVersionName":
                _systemVersionName = value;
                break;
              case "systemVersionCode":
                _systemVersionCode = value;
                break;
              case "PN":
                _PN = value;
                break;
              case "terminalUniqueSerialNumber":
                _terminalUniqueSerialNumber = value;
                break;
              case "firmwareVersion":
                _firmwareVersion = value;
                break;
              case "hardwareVersion":
                _hardwareVersion = value;
                break;
              case "debugMode":
                _debugMode = value;
                break;
              case "reserved":
                _reserved = value;
                break;
              case "supportETC":
                _supportETC = value;
                break;
            }
          }
        )
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
          _textWidget("Device Code: $_deviceCode"),
          _textWidget("Device Model: $_deviceModel"),
          _textWidget("Device Brand: $_deviceBrand"),
          _textWidget("Serial Number: $_serialNumber"),
          _textWidget("System Version Name: $_systemVersionName"),
          _textWidget("System Version Code: $_systemVersionCode"),
          _textWidget("PN: $_PN"),
          _textWidget("Terminal Unique Serial Number: $_terminalUniqueSerialNumber"),
          _textWidget("Firmware Version: $_firmwareVersion"),
          _textWidget("Hardware Version: $_hardwareVersion"),
          _textWidget("DebugMode: $_debugMode"),
          _textWidget("Support ETC: $_supportETC"),
          _textWidget("Reserved: $_reserved"),
        ],
      ),
    );
  }

  _textWidget(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.start,),
    );
  }

}