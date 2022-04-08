
import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/plugins/DeviceInfoEngine.dart';

class GetSystemParameterPage extends StatelessWidget {

  const GetSystemParameterPage( { Key ? key } ) : super(key: key);

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
  String _debugMode = "";
  String _pn = "";
  String _tuSN = "";
  String _firmwareVersion = "";
  String _hardwareVersion = "";
  String _reserved = "";
  String _supportETC = "";

  @override
  void initState() {
    super.initState();
    _getSystemParameters(DeviceInfoEngine.deviceCode);
    _getSystemParameters(DeviceInfoEngine.deviceModel);
    _getSystemParameters(DeviceInfoEngine.deviceBrand);
    _getSystemParameters(DeviceInfoEngine.serialNumber);
    _getSystemParameters(DeviceInfoEngine.systemVersionName);
    _getSystemParameters(DeviceInfoEngine.systemVersionCode);
    _getSystemParameters(DeviceInfoEngine.debugMode);
    _getSystemParameters(DeviceInfoEngine.pn);
    _getSystemParameters(DeviceInfoEngine.terminalUniqueSerialNumber);
    _getSystemParameters(DeviceInfoEngine.firmwareVersion);
    _getSystemParameters(DeviceInfoEngine.hardwareVersion);
    _getSystemParameters(DeviceInfoEngine.reserved);
    _getSystemParameters(DeviceInfoEngine.supportETC);
  }

  _getSystemParameters(String key) {
    DeviceInfoEngine.getSystemParameters(key).then( (value) => {
        setState( () {
          switch (key) {
              case DeviceInfoEngine.deviceCode:
                _deviceCode = value;
                break;
              case DeviceInfoEngine.deviceModel:
                _deviceModel = value;
                break;
              case DeviceInfoEngine.deviceBrand:
                _deviceBrand = value;
                break;
              case DeviceInfoEngine.serialNumber:
                _serialNumber = value;
                break;
              case DeviceInfoEngine.systemVersionName:
                _systemVersionName = value;
                break;
              case DeviceInfoEngine.systemVersionCode:
                _systemVersionCode = value;
                break;
              case DeviceInfoEngine.debugMode:
                _debugMode = value;
                break;
              case DeviceInfoEngine.pn:
                _pn = value;
                break;
              case DeviceInfoEngine.terminalUniqueSerialNumber:
                _tuSN = value;
                break;
              case DeviceInfoEngine.firmwareVersion:
                _firmwareVersion = value;
                break;
              case DeviceInfoEngine.hardwareVersion:
                _hardwareVersion = value;
                break;
              case DeviceInfoEngine.reserved:
                _reserved = value;
                break;
              case DeviceInfoEngine.supportETC:
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
          _textWidget("DebugMode: $_debugMode"),
          _textWidget("PN: $_pn"),
          _textWidget("T U S N: $_tuSN"),
          _textWidget("Firmware Version: $_firmwareVersion"),
          _textWidget("Hardware Version: $_hardwareVersion"),
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
      child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.start, ),
    );
  }

}