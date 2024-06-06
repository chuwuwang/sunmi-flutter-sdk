package com.sunmi.flutter.sdk

import android.util.Log
import com.sunmi.pay.hardware.aidl.AidlConstants
import com.sunmi.sunmi_flutter_sdk.MainActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceInfoRemoteEngine : FlutterPlugin {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val methodChannel = MethodChannel(binding.binaryMessenger, "device-info-engine")
        methodChannel.setMethodCallHandler(methodCallHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
        val method = call.method
        if (method == "getSystemParameters") {
            getSystemParameters(call, result)
        } else if (method == "buzzer") {
            buzzer(call)
        } else if (method == "enableScreenMonopoly") {
            enableScreenMonopoly()
        } else if (method == "disableScreenMonopoly") {
            disableScreenMonopoly()
        } else if (method == "enableStatusBarDropDown") {
            enableStatusBarDropDown()
        } else if (method == "disableStatusBarDropDown") {
            disableStatusBarDropDown()
        } else if (method == "showNavigationBar") {
            showNavigationBar()
        } else if (method == "hideNavigationBar") {
            hideNavigationBar()
        } else if (method == "hideNavigationBarItemKey") {
            hideNavigationBarItemKey(call)
        } else {
            result.notImplemented()
        }
    }

    private fun getSystemParameters(call: MethodCall, result: MethodChannel.Result) {
        var resultString: String ? = null
        val arguments = call.arguments
        if (arguments is String) {
            resultString = BasicModuleWrapper.getSysParam(arguments)
        }
        if (resultString == null) resultString = ""
        result.success(resultString)
    }

    private fun buzzer(call: MethodCall) {
        try {
            val time = call.argument<Int>("time") ?: 3
            val delay = call.argument<Int>("delay") ?: 500
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.buzzerOnDevice(time, 3000, 500, delay)
            } else {
                Log.e(Constant.TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    private fun enableScreenMonopoly() {
        BasicModuleWrapper.setScreenMode(AidlConstants.SystemUI.SET_SCREEN_MONOPOLY)
    }

    private fun disableScreenMonopoly() {
        BasicModuleWrapper.setScreenMode(AidlConstants.SystemUI.CLEAR_SCREEN_MONOPOLY)
    }

    private fun enableStatusBarDropDown() {
        BasicModuleWrapper.setStatusBarDropDownMode(AidlConstants.SystemUI.ENABLE_STATUS_BAR_DROP_DOWN)
    }

    private fun disableStatusBarDropDown() {
        BasicModuleWrapper.setStatusBarDropDownMode(AidlConstants.SystemUI.DISABLE_STATUS_BAR_DROP_DOWN)
    }

    private fun hideNavigationBar() {
        BasicModuleWrapper.setNavigationBarVisibility(AidlConstants.SystemUI.HIDE_NAV_BAR)
    }

    private fun showNavigationBar() {
        BasicModuleWrapper.setNavigationBarVisibility(AidlConstants.SystemUI.SHOW_NAV_BAR)
    }

    private fun hideNavigationBarItemKey(call: MethodCall) {
        if (call.arguments is Int) {
            val key = call.arguments as Int
            BasicModuleWrapper.setHideNavigationBarItems(key)
        }
    }

}