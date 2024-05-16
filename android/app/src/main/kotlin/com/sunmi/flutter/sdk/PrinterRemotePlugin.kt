package com.sunmi.flutter.sdk

import android.content.Context
import android.graphics.BitmapFactory
import android.util.Log
import com.sunmi.peripheral.printer.InnerPrinterCallback
import com.sunmi.peripheral.printer.InnerPrinterManager
import com.sunmi.peripheral.printer.InnerResultCallback
import com.sunmi.peripheral.printer.SunmiPrinterService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PrinterRemotePlugin : FlutterPlugin {

    private lateinit var context: Context
    private var printerService: SunmiPrinterService ? = null

    private var isPrinterBuffer = false
    private lateinit var methodCall: MethodCall
    private var methodResult: MethodChannel.Result ? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        val methodChannel = MethodChannel(binding.binaryMessenger, "printer-engine")
        methodChannel.setMethodCallHandler(methodCallHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    private val methodCallHandler = MethodChannel.MethodCallHandler { call, result ->
        methodCall = call
        methodResult = result
        if (call.method == "initPrinter") {
            initPrinter()
        } else if (call.method == "getPrinterStatus") {
            getPrinterStatus()
        } else if (call.method == "reset") {
            reset()
        }
        ////////////////////////////////////////////////////////////////////////////////////////////
        else if (call.method == "setFontBold") {
            setFontBold()
        } else if (call.method == "setFontSize") {
            setFontSize()
        } else if (call.method == "setFontAlignment") {
            setFontAlignment()
        } else if (call.method == "setFontRowHeight") {
            setFontRowHeight()
        }
        ////////////////////////////////////////////////////////////////////////////////////////////
        else if (call.method == "printText") {
            printText()
        } else if (call.method == "printImage") {
            printImage()
        } else if (call.method == "printBarcode") {
            printBarcode()
        } else if (call.method == "printQRCode") {
            printQRCode()
        } else if (call.method == "printTable") {
            printTable()
        } else if (call.method == "printLine") {
            printLine()
        }
        ////////////////////////////////////////////////////////////////////////////////////////////
        else if (call.method == "enterPrinterBuffer") {
            enterPrinterBuffer()
        } else if (call.method == "exitPrinterBuffer") {
            exitPrinterBuffer()
        } else {
            result.notImplemented()
        }
    }

    private fun initPrinter() {
        isPrinterBuffer = false
        try {
            if (printerService == null) {
                InnerPrinterManager.getInstance().bindService(context, serviceConnection)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private val serviceConnection = object : InnerPrinterCallback() {

        override fun onConnected(sunmiPrinterService: SunmiPrinterService ? ) {
            Log.e(Constant.TAG, "onConnected")
            isPrinterBuffer = false
            printerService = sunmiPrinterService
            returnSuccess("Connected printer successful")
        }

        override fun onDisconnected() {
            Log.e(Constant.TAG, "onDisconnected")
            isPrinterBuffer = false
            returnError("-100", "Connected printer failed")
        }

    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    private fun getPrinterStatus() {
        var state = -1
        try {
            val printer = printerService
            if (printer != null) {
                state = printer.updatePrinterState()
            } else {
                Log.e(Constant.TAG, "printerService si null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
        returnSuccess(state)
    }

    private fun reset() {
        try {
            val printer = printerService
            if (printer != null) {
                printer.printerInit(resultCallback)
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun setFontBold() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is Boolean) {
                    val bold = methodCall.arguments as Boolean
                    val returnText = ByteArray(3)
                    returnText[0] = 0x1B
                    returnText[1] = 0x45
                    if (bold) {
                        returnText[2] = 0x01
                    } else {
                        returnText[2] = 0x00
                    }
                    printer.sendRAWData(returnText, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun setFontSize() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is Int) {
                    val fontSize = methodCall.arguments as Int
                    printer.setFontSize(fontSize.toFloat(), resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun setFontAlignment() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is Int) {
                    val alignment = methodCall.arguments as Int
                    printer.setAlignment(alignment, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun setFontRowHeight() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is Int) {
                    val height = methodCall.arguments as Int
                    val returnText = ByteArray(3)
                    returnText[0] = 0x1B
                    returnText[1] = 0x33
                    returnText[2] = height.toByte()
                    printer.sendRAWData(returnText, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    private fun printText() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is String) {
                    val text = methodCall.arguments as String
                    printer.printText(text, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun printImage() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is ByteArray) {
                    val data = methodCall.arguments as ByteArray
                    val bitmap = BitmapFactory.decodeByteArray(data, 0, data.size)
                    printer.printBitmap(bitmap, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun printBarcode() {
        try {
            val printer = printerService
            if (printer != null) {
                val width = methodCall.argument<Int>("width") ?: 2
                val data = methodCall.argument<String>("data") ?: ""
                val height = methodCall.argument<Int>("height") ?: 162
                val symbology = methodCall.argument<Int>("symbology") ?: 8
                val textPosition = methodCall.argument<Int>("textPosition") ?: 2
                printer.printBarCode(data, symbology, height, width, textPosition, resultCallback)
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun printQRCode() {
        try {
            val printer = printerService
            if (printer != null) {
                val data = methodCall.argument<String>("data") ?: ""
                val moduleSize = methodCall.argument<Int>("moduleSize") ?: 8
                val errorLevel = methodCall.argument<Int>("errorLevel") ?: 2
                printer.printQRCode(data, moduleSize, errorLevel, resultCallback)
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun printTable() {
        try {
            val printer = printerService
            if (printer != null) {
                val widthList = methodCall.argument< List<Int> >("columnWidth")
                val alignList = methodCall.argument< List<Int> >("columnAlign")
                val textList = methodCall.argument< List<String> >("columnText")
                if (textList != null) {
                    val columnText = arrayOfNulls<String>(textList.size)
                    for (i in textList.indices) {
                        columnText[i] = textList[i]
                    }
                    val columnWidth = intArrayOf(1, 1, 1)
                    if (widthList != null) {
                        for (i in widthList.indices) {
                            columnWidth[i] = widthList[i]
                        }
                    }
                    val columnAlign = intArrayOf(0, 0, 0)
                    if (alignList != null) {
                        for (i in alignList.indices) {
                            columnAlign[i] = alignList[i]
                        }
                    }
                    printer.printColumnsString(columnText, columnWidth, columnAlign, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun printLine() {
        try {
            val printer = printerService
            if (printer != null) {
                if (methodCall.arguments is Int) {
                    val line = methodCall.arguments as Int
                    printer.lineWrap(line, resultCallback)
                }
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private fun enterPrinterBuffer() {
        isPrinterBuffer = true
        try {
            val printer = printerService
            if (printer != null) {
                printer.enterPrinterBuffer(true)
            } else {
                Log.e(Constant.TAG, "printerService is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    private fun exitPrinterBuffer() {
        try {
            val printer = printerService
            if (printer != null) {
                printer.exitPrinterBufferWithCallback(true, resultCallback)
            } else {
                returnErrorByNull()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            returnErrorByException()
        }
    }

    private val resultCallback = object : InnerResultCallback() {

        override fun onRunResult(isSuccess: Boolean) {
            Log.e(Constant.TAG, "onRunResult: $isSuccess")
            if (isPrinterBuffer) return
            try {
                if (isSuccess) {
                    returnSuccess("Command executed successfully")
                } else {
                    returnError("-202", "Command executed failed")
                }
            } catch (e: Throwable) {
                e.printStackTrace()
            }
        }

        override fun onReturnString(msg: String ? ) {
            Log.e(Constant.TAG, "onReturnString: $msg")
        }

        override fun onRaiseException(code: Int, msg: String ? ) {
            Log.e(Constant.TAG, "onRaiseException: $code $msg")
        }

        override fun onPrintResult(code: Int, msg: String ? ) {
            Log.e(Constant.TAG, "onPrintResult: $code $msg")
            try {
                if (code == 0) {
                    returnSuccess("Print successfully")
                } else {
                    returnError("$code", msg ?: "Print failed")
                }
            } catch (e: Throwable) {
                e.printStackTrace()
            }
            isPrinterBuffer = false
        }

    }

    private fun returnSuccess(any: Any) {
        val result = methodResult
        if (result != null) {
            result.success(any)
        } else {
            Log.e(Constant.TAG, "result is null")
        }
        methodResult = null
    }

    private fun returnErrorByNull() {
        returnError("-200", "printerService is null")
    }

    private fun returnErrorByException() {
        returnError("-201", "printer exception")
    }

    private fun returnError(code: String, message: String) {
        val result = methodResult
        if (result != null) {
            result.error(code, message, "printer error")
        } else {
            Log.e(Constant.TAG, "result is null")
        }
        methodResult = null
    }

}