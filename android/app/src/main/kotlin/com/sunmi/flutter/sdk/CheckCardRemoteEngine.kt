package com.sunmi.flutter.sdk

import android.content.Context
import com.google.gson.Gson
import com.sunmi.flutter.sdk.card.CardInfo
import com.sunmi.flutter.sdk.card.CheckCardProcessImpl
import com.sunmi.flutter.sdk.util.Logger
import com.sunmi.sunmi_flutter_sdk.MainActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class CheckCardRemoteEngine : FlutterPlugin {

    private lateinit var context: Context

    private val gson = Gson()
    private var methodResult: MethodChannel.Result ? = null
    private var checkCardProcess: CheckCardProcessImpl ? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        val methodChannel = MethodChannel(binding.binaryMessenger, "check-card-engine")
        methodChannel.setMethodCallHandler(methodCallHandler)
        initReceiver()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodResult = null
        checkCardProcess = null
    }

    private fun initReceiver() {
        val readCardOpt = MainActivity.readCardOpt
        if (readCardOpt != null) {
            val impl = CheckCardProcessImpl(readCardOpt)
            impl.onCheckCardSuccess = { info -> onCheckCardSuccess(info) }
            impl.onCheckCardFailure = { code, desc -> onCheckCardFailure(code, desc) }
            checkCardProcess = impl
        }
    }

    private fun onCheckCardSuccess(info: CardInfo) {
        try {
            val jsonString = gson.toJson(info)
            Logger.e("onCheckCardSuccess ---> $jsonString")
            val result = methodResult
            if (result != null) {
                result.success(jsonString)
            } else {
                Logger.e("methodResult is null")
            }
            methodResult = null
        } catch (e: Throwable) {
            e.printStackTrace()
            onError(e.localizedMessage ?: "")
        }
    }

    private fun onCheckCardFailure(code: Int, desc: String) {
        try {
            Logger.e("onCheckCardFailure ---> $code, $desc")
            val result = methodResult
            if (result != null) {
                result.error("$code", desc, desc)
            } else {
                Logger.e("methodResult is null")
            }
            methodResult = null
        } catch (e: Throwable) {
            e.printStackTrace()
            onError(e.localizedMessage ?: "")
        }
    }

    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
        val method = call.method
        if (method == "startCheckCard") {
            methodResult = result
            startCheckCard(call)
        } else if (method == "stopCheckCard") {
            stopCheckCard()
        } else {
            result.notImplemented()
        }
    }

    private fun startCheckCard(methodCall: MethodCall) {
        val cardType = methodCall.argument<Int>("cardType") ?: (1 or 2 or 4)
        val timeout = methodCall.argument<Int>("timeout") ?: 60
        val cardProcessImpl = checkCardProcess
        if (cardProcessImpl != null) {
            cardProcessImpl.startCheckCard(cardType, timeout)
        }
    }

    private fun stopCheckCard() {
        val cardProcessImpl = checkCardProcess
        if (cardProcessImpl != null) {
            cardProcessImpl.cancelCheckCard()
        }
    }

    private fun onError(message: String) {
        try {
            val result = methodResult
            if (result != null) {
                result.error("500", "Unknown error", message)
            } else {
                Logger.e("methodResult is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
        methodResult = null
    }

}