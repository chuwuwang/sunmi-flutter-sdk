package com.sunmi.flutter.sdk

import android.util.Log
import com.sunmi.pay.hardware.aidl.AidlConstants
import com.sunmi.sunmi_flutter_sdk.MainActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceInfoRemoteEngine : FlutterPlugin {

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
        val method = call.method
        if (method == "getSystemParameters") {
            getSystemParameters(call, result)
        }


//        when (call.method) {
//            "getSystemParameters" -> getSystemParameters(call, result)
//            "enableScreenMonopoly" -> enableScreenMonopoly()
//            "disableScreenMonopoly" -> disableScreenMonopoly()
//            "enableStatusBarDropDown" -> enableStatusBarDropDown()
//            "disableStatusBarDropDown" -> disableStatusBarDropDown()
//            "hideNavigationBar" -> hideNavigationBar()
//            "showNavigationBar" -> showNavigationBar()
//            "hideNavigationBarItemKey" -> hideNavigationBarItemKey(call)
//            else -> result.notImplemented()
//        }
    }

    private fun getSystemParameters(call: MethodCall, result: MethodChannel.Result) {
        var resultString: String ? = null
        val arguments = call.arguments
        if (arguments is String) {
            resultString = getSysParam(arguments)
        }
        if (resultString == null) resultString = ""
        result.success(resultString)
    }

    private fun enableScreenMonopoly() {
        setScreenMode(AidlConstants.SystemUI.SET_SCREEN_MONOPOLY)
    }

    private fun disableScreenMonopoly() {
        setScreenMode(AidlConstants.SystemUI.CLEAR_SCREEN_MONOPOLY)
    }

    private fun enableStatusBarDropDown() {
        setStatusBarDropDownMode(AidlConstants.SystemUI.ENABLE_STATUS_BAR_DROP_DOWN)
    }

    private fun disableStatusBarDropDown() {
        setStatusBarDropDownMode(AidlConstants.SystemUI.DISABLE_STATUS_BAR_DROP_DOWN)
    }

    private fun hideNavigationBar() {
        setNavigationBarVisibility(AidlConstants.SystemUI.HIDE_NAV_BAR)
    }

    private fun showNavigationBar() {
        setNavigationBarVisibility(AidlConstants.SystemUI.SHOW_NAV_BAR)
    }

    private fun hideNavigationBarItemKey(call: MethodCall) {
        if (call.arguments is Int) {
            val key = call.arguments as Int
            setHideNavigationBarItems(key)
        }
    }

    private fun getSysParam(parameter: String): String ? {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                return basicOpt.getSysParam(parameter)
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
        return null
    }

    private fun setScreenMode(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setScreenMode(key)
            } else {
                Log.e(TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    private fun setStatusBarDropDownMode(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setStatusBarDropDownMode(key)
            } else {
                Log.e(TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    private fun setNavigationBarVisibility(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setNavigationBarVisibility(key)
            } else {
                Log.e(TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    private fun setHideNavigationBarItems(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setHideNavigationBarItems(key)
            } else {
                Log.e(TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

}