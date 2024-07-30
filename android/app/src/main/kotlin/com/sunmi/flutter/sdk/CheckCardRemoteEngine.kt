package com.sunmi.flutter.sdk

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class CheckCardRemoteEngine : FlutterPlugin {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val methodChannel = MethodChannel(binding.binaryMessenger, "check-card-engine")
        methodChannel.setMethodCallHandler(methodCallHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
        val method = call.method
        if (method == "startCheckCard") {
            startCheckCard(call, result)
        } else if (method == "stopCheckCard") {
            stopCheckCard()
        } else {
            result.notImplemented()
        }
    }

}