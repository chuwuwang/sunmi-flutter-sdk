package com.sunmi.sunmi_flutter_sdk

import android.content.Intent
import android.util.Log
import com.sunmi.pay.hardware.aidlv2.system.BasicOptV2
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import sunmi.paylib.SunmiPayKernel

class MainActivity : FlutterActivity() {

    companion object {
         const val TAG = "sun-mi-flutter"
        var basicOptV2: BasicOptV2 ? = null
    }

    private val scanEngine = ScanEngine(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val deviceInfoEngine = DeviceInfoEngine()
        val printerRemotePlugin = PrinterRemotePlugin()
        flutterEngine.plugins.add(scanEngine)
        flutterEngine.plugins.add(deviceInfoEngine)
        flutterEngine.plugins.add(printerRemotePlugin)

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

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent ? ) {
        if (requestCode == 100 && data != null) {
            val bundle = data.extras
            if (bundle != null) {
                val obj = bundle.getSerializable("data")
                if (obj != null && obj is ArrayList<*>) {
                    val result = obj as ArrayList< HashMap<String, String> >
                    if (result != null && result.size > 0) {
                        val type = result[0]["TYPE"]
                        val value = result[0]["VALUE"]
                        Log.e(TAG, "type: $type")
                        Log.e(TAG, "value: $value")
                        scanEngine.returnScanResult(type, value)
                    }
                }
            }
        }
        super.onActivityResult(requestCode, resultCode, data)
    }

}