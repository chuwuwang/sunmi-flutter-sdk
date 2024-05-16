package com.sunmi.flutter.sdk

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class ScannerEngine(private val activity: Activity) : FlutterPlugin {

    private lateinit var context: Context

    private var methodResult: MethodChannel.Result ? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        val methodChannel = MethodChannel(binding.binaryMessenger, "scanner-engine")
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
        intent.action = "com.sum" + "mi.scan"
        intent.setPackage("com.sunmi.sun" + "mi" + "qr" + "code" + "scanner")
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

    fun onActivityForResult(requestCode: Int, resultCode: Int, data: Intent ? ) {
        if (data == null || requestCode != 100) return
        val bundle = data.extras ?: return
        val obj = bundle.getSerializable("data")
        if (obj != null && obj is ArrayList<*>) {
            val result = obj as ArrayList< HashMap<String, String> >
            if (result != null && result.size > 0) {
                val type = result[0]["TYPE"] ?: ""
                val value = result[0]["VALUE"] ?: ""
                Log.e(Constant.TAG, "type: $type")
                Log.e(Constant.TAG, "value: $value")
                returnScanResult(type, value)
            }
        }
    }

    private fun returnScanResult(type: String, value: String) {
        val result = methodResult ?: return
        val map = HashMap<String, String>()
        map["type"] = type
        map["value"] = value
        result.success(map)
        methodResult = null
    }

}