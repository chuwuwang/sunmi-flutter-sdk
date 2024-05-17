import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/device_info_constant.dart';
import 'package:sun_mi_flutter_sdk/engine/plugins/device_info_engine.dart';
import 'package:sun_mi_flutter_sdk/pages/base_state.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateful_widget.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

class BasicGetSystemParameterPage extends BaseStatelessWidget {

  const BasicGetSystemParameterPage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Get System Parameters";

  @override
  Widget onCreateChild(BuildContext context) => const DeviceInfoWidget();

}

class DeviceInfoWidget extends BaseStatefulWidget {

  const DeviceInfoWidget( { Key ? key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() => DeviceInfoState();

}

class DeviceInfoState extends BaseState<DeviceInfoWidget> {

  final _resultBuffer = StringBuffer();

  @override
  void initState() {
    super.initState();
    _getSystemParameters();
  }

  _getSystemParameters() {
    List<String> keys = [];
    keys.add(DeviceInfoConstant.BASE_VERSION);
    keys.add(DeviceInfoConstant.MSR2_FW_VER);
    keys.add(DeviceInfoConstant.HARDWARE_VERSION);
    keys.add(DeviceInfoConstant.FIRMWARE_VERSION);
    keys.add(DeviceInfoConstant.SM_VERSION);
    keys.add(DeviceInfoConstant.ETC_FIRM_VERSION);
    keys.add(DeviceInfoConstant.BootVersion);
    keys.add(DeviceInfoConstant.CFG_FILE_VERSION);
    keys.add(DeviceInfoConstant.FW_VERSION);
    keys.add(DeviceInfoConstant.SN);
    keys.add(DeviceInfoConstant.PN);
    keys.add(DeviceInfoConstant.TUSN);
    keys.add(DeviceInfoConstant.DEVICE_CODE);
    keys.add(DeviceInfoConstant.DEVICE_MODEL);
    keys.add(DeviceInfoConstant.RESERVED);
    keys.add(DeviceInfoConstant.PINPAD_MODE);
    keys.add(DeviceInfoConstant.PCD_PARAM_A);
    keys.add(DeviceInfoConstant.PCD_PARAM_B);
    keys.add(DeviceInfoConstant.PCD_PARAM_C);
    keys.add(DeviceInfoConstant.PUSH_CFG_FILE);
    keys.add(DeviceInfoConstant.SUPPORT_ETC);
    keys.add(DeviceInfoConstant.TUSN_KEY_KCV);
    keys.add(DeviceInfoConstant.SEC_MODE);
    keys.add(DeviceInfoConstant.PCD_IFM_VERSION);
    keys.add(DeviceInfoConstant.EMV_VERSION);
    keys.add(DeviceInfoConstant.PAYPASS_VERSION);
    keys.add(DeviceInfoConstant.PAYWAVE_VERSION);
    keys.add(DeviceInfoConstant.QPBOC_VERSION);
    keys.add(DeviceInfoConstant.ENTRY_VERSION);
    keys.add(DeviceInfoConstant.MIR_VERSION);
    keys.add(DeviceInfoConstant.JCB_VERSION);
    keys.add(DeviceInfoConstant.PAGO_VERSION);
    keys.add(DeviceInfoConstant.PURE_VERSION);
    keys.add(DeviceInfoConstant.AE_VERSION);
    keys.add(DeviceInfoConstant.FLASH_VERSION);
    keys.add(DeviceInfoConstant.DPAS_VERSION);
    keys.add(DeviceInfoConstant.APEMV_VERSION);
    keys.add(DeviceInfoConstant.EFTPOS_VERSION);
    keys.add(DeviceInfoConstant.EMVBASE_VERSION);
    keys.add(DeviceInfoConstant.KD_VERSION);
    keys.add(DeviceInfoConstant.EMV_KERNEL_CHECKSUM);
    keys.add(DeviceInfoConstant.PURE_RELEASE_DATE);
    keys.add(DeviceInfoConstant.EFTPOS_RELEASE_DATE);
    keys.add(DeviceInfoConstant.EMV_RELEASE_DATE);
    keys.add(DeviceInfoConstant.PAYPASS_RELEASE_DATE);
    keys.add(DeviceInfoConstant.PAYWAVE_RELEASE_DATE);
    keys.add(DeviceInfoConstant.QPBOC_RELEASE_DATE);
    keys.add(DeviceInfoConstant.ENTRY_RELEASE_DATE);
    keys.add(DeviceInfoConstant.MIR_RELEASE_DATE);
    keys.add(DeviceInfoConstant.JCB_RELEASE_DATE);
    keys.add(DeviceInfoConstant.PAGO_RELEASE_DATE);
    keys.add(DeviceInfoConstant.AE_RELEASE_DATE);
    keys.add(DeviceInfoConstant.FLASH_RELEASE_DATE);
    keys.add(DeviceInfoConstant.DPAS_RELEASE_DATE);
    keys.add(DeviceInfoConstant.EMVBASE_RELEASE_DATE);
    keys.add(DeviceInfoConstant.KD_RELEASE_DATE);
    keys.add(DeviceInfoConstant.TAMPER_LOG);
    keys.add(DeviceInfoConstant.CLEAR_TAMPER_LOG);
    keys.add(DeviceInfoConstant.TERM_STATUS);
    keys.add(DeviceInfoConstant.CLEAR_TAMPER);
    keys.add(DeviceInfoConstant.DEBUG_MODE);
    keys.add(DeviceInfoConstant.EMV_MASK);

    for (var key in keys) {
      onSuccess(value) {
        var contains = key.contains("ReleaseDate");
        if (contains == false) {
          _resultBuffer.write(key);
          _resultBuffer.write(": ");
        }
        callback() => _resultBuffer.write("$value\n");
        setState(callback);
      }
      DeviceInfoEngine.getSystemParameters(key).then(onSuccess).catchError(onError);
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: ColorHelper.textContentColor, fontSize: 14, height: 1.6);
    var text = Text(_resultBuffer.toString(), style: style, textAlign: TextAlign.start);
    var container = Container(margin: const EdgeInsets.all(16), alignment: Alignment.centerLeft, child: text);
    return SingleChildScrollView(child: container);
  }

}
