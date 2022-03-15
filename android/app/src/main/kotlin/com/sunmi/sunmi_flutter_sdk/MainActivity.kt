package com.sunmi.sunmi_flutter_sdk

import com.sunmi.pay.hardware.aidlv2.system.BasicOptV2
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import sunmi.paylib.SunmiPayKernel

class MainActivity : FlutterActivity() {

    companion object {
        var basicOptV2: BasicOptV2 ? = null
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val testRemotePlugin = TestRemotePlugin()
        val deviceInfoEngine = DeviceInfoEngine()
        flutterEngine.plugins.add(testRemotePlugin)
        flutterEngine.plugins.add(deviceInfoEngine)

        GeneratedPluginRegistrant.registerWith(flutterEngine)

        bindSDKService()
    }

    private fun bindSDKService() {
        SunmiPayKernel.getInstance().initPaySDK(baseContext, connectCallback)
    }

    private val connectCallback = object : SunmiPayKernel.ConnectCallback {

        override fun onConnectPaySDK() {
            basicOptV2 = SunmiPayKernel.getInstance().mBasicOptV2
        }

        override fun onDisconnectPaySDK() {

        }

    }

}