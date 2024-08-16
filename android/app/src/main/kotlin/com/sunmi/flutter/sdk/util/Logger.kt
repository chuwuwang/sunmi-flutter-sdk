package com.sunmi.flutter.sdk.util

import android.util.Log

object Logger {

    @JvmStatic
    fun e(msg: String) {
        Log.e("mf", msg)
    }

}