package com.sunmi.sunmi_flutter_sdk

import android.content.Context
import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class ScanEngine(private val activity: MainActivity) : FlutterPlugin {

    private lateinit var context: Context

    private var methodResult: MethodChannel.Result ? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        val methodChannel = MethodChannel(binding.binaryMessenger, "scan-engine")
        methodChannel.setMethodCallHandler(methodCallHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
        val method = call.method
        if (method == "startScan") {
            methodResult = result
            startScan()
        } else {
            result.notImplemented()
        }
    }

    private fun startScan() {
        val intent = Intent()
        intent.action = "com.summi.scan"
        intent.setPackage("com.sunmi.sunmiqrcodescanner")
        intent.putExtra("IS_SHOW_SETTING", false)       // whether to display the setting button, default true
        intent.putExtra("IDENTIFY_MORE_CODE", true)     // identify multiple qr code in the screen
        intent.putExtra("IS_AZTEC_ENABLE", true)        // allow read of AZTEC code
        intent.putExtra("IS_PDF417_ENABLE", true)       // allow read of PDF417 code
        intent.putExtra("IS_DATA_MATRIX_ENABLE", true)  // allow read of DataMatrix code
        if (intent.resolveActivity(context.packageManager) != null) {
            activity.startActivityForResult(intent, 100)
        } else {
            methodResult = null
            Toast.makeText(context, "Can't open scanner", Toast.LENGTH_SHORT).show()
        }
    }

    fun returnScanResult(type: String ? = null, value: String ? = null) {
        val result = methodResult ?: return
        if (value != null) {
            val map = HashMap<String, String ? >()
            map["type"] = type
            map["value"] = value
            result.success(map)
        } else {
            result.error("-100", "Scan failed", "Scan failed")
        }
        methodResult = null
    }

}