package com.sunmi.sunmi_flutter_sdk

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TestRemotePlugin : FlutterPlugin {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val methodChannel = MethodChannel(binding.binaryMessenger, "test-remote-plugin")
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
        val serialNumber = DeviceHelper.getSerialNumber()
        result.success(serialNumber)
    }

}