package com.sunmi.flutter.sdk

import android.os.Build

object DeviceHelper {

    fun getDeviceModel(): String {
        return Build.MODEL
    }

    fun getSerialNumber(): String {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                return Build.getSerial()
            } else {
                return SystemPropertiesHelper.get("ro.serial" + "no")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
        return ""
    }

}