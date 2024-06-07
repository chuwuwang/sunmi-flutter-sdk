package com.sunmi.sunmi_flutter_sdk

import android.content.Intent
import android.util.Log
import com.sunmi.flutter.sdk.Constant
import com.sunmi.flutter.sdk.DeviceInfoRemoteEngine
import com.sunmi.flutter.sdk.PrinterRemotePlugin
import com.sunmi.flutter.sdk.ScannerRemoteEngine
import com.sunmi.pay.hardware.aidlv2.system.BasicOptV2
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import sunmi.paylib.SunmiPayKernel

class MainActivity : FlutterActivity() {

    companion object {

        var basicOptV2: BasicOptV2 ? = null

    }

    private val scannerRemoteEngine = ScannerRemoteEngine(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val printerRemotePlugin = PrinterRemotePlugin()
        val deviceInfoRemoteEngine = DeviceInfoRemoteEngine()
        flutterEngine.plugins.add(scannerRemoteEngine)
        flutterEngine.plugins.add(printerRemotePlugin)
        flutterEngine.plugins.add(deviceInfoRemoteEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        bindSDKService()
    }

    private fun bindSDKService() {
        SunmiPayKernel.getInstance().initPaySDK(baseContext, connectCallback)
    }

    private val connectCallback = object : SunmiPayKernel.ConnectCallback {

        override fun onConnectPaySDK() {
            Log.e(Constant.TAG, "onConnectPaySDK")
            basicOptV2 = SunmiPayKernel.getInstance().mBasicOptV2
        }

        override fun onDisconnectPaySDK() {
            Log.e(Constant.TAG, "onDisconnectPaySDK")
            basicOptV2 = null
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent ? ) {
        super.onActivityResult(requestCode, resultCode, data)
        scannerRemoteEngine.onActivityForResult(requestCode, resultCode, data)
    }

}