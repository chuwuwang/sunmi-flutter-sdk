package com.sunmi.sunmi_flutter_sdk

import android.annotation.SuppressLint
import android.os.Build

object DeviceHelper {

    @SuppressLint("MissingPermission")
    fun getSerialNumber(): String {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                Build.getSerial()
            } else {
                SystemPropertiesHelper.get("ro.serial" + "no")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            ""
        }
    }

}