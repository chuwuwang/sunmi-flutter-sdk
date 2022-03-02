package com.sunmi.sunmi_flutter_sdk

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val testRemotePlugin = TestRemotePlugin()
        flutterEngine.plugins.add(testRemotePlugin)

        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

}