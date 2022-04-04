package com.sunmi.sunmi_flutter_sdk

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceInfoEngine : FlutterPlugin {

    companion object {
        private const val TAG = "DeviceInfoEngine"
        private const val deviceCode = "DeviceCode"
        private const val deviceModel = "ro.product.model"
        private const val deviceBrand = "ro.product.brand"
        private var systemVersionName = "ro.version.sunMi_versionName".lowercase()
        private var systemVersionCode = "ro.version.sunMi_versionCode".lowercase()
        private var terminalUniqueSerialNumber = "tuSN".uppercase()
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val methodChannel = MethodChannel(binding.binaryMessenger, "device-info-engine")
        methodChannel.setMethodCallHandler(methodCallHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
        Log.e("ktx", "onMethodCall call: $call")
        val method = call.method
        if (method == "getSystemParameters") {
            getSystemParameters(call, result)
        } else {
            result.notImplemented()
        }
    }

    private fun getSystemParameters(call: MethodCall, result: MethodChannel.Result) {
        var resultString: String? = null
        when (call.arguments as String) {
            "deviceCode" -> resultString = getSysParam(deviceCode)
            "deviceModel" -> resultString = SystemPropertiesHelper.get(deviceModel)
            "deviceBrand" -> resultString = SystemPropertiesHelper.get(deviceBrand)
            "serialNumber" -> resultString = DeviceHelper.getSerialNumber()
            "systemVersionName" -> resultString = SystemPropertiesHelper.get(systemVersionName)
            "systemVersionCode" -> resultString = SystemPropertiesHelper.get(systemVersionCode)
            "PN" -> resultString = getSysParam("PN")
            "terminalUniqueSerialNumber" -> resultString = getSysParam(terminalUniqueSerialNumber)
            "firmwareVersion" -> resultString = getSysParam("FirmwareVersion")
            "hardwareVersion" -> resultString = getSysParam("HardwareVersion")
            "debugMode" -> resultString = getSysParam("DebugMode")
            "reserved" -> resultString = getSysParam("Reserved")
            "supportETC" -> resultString = getSysParam("SupportETC")
        }
        if (resultString == null) resultString = ""
        result.success(resultString)
    }

    private fun getSysParam(parameter: String): String ? {
        return try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.getSysParam(parameter)
            } else {
                Log.e(TAG, "basicOptV2 is null")
                null
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            null
        }
    }

}