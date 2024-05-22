package com.sunmi.flutter.sdk

import android.util.Log
import com.sunmi.sunmi_flutter_sdk.MainActivity

object BasicModuleWrapper {

    fun getSysParam(parameter: String): String ? {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                return basicOpt.getSysParam(parameter)
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
        return null
    }

    fun setScreenMode(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setScreenMode(key)
            } else {
                Log.e(Constant.TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    fun setStatusBarDropDownMode(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setStatusBarDropDownMode(key)
            } else {
                Log.e(Constant.TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    fun setNavigationBarVisibility(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setNavigationBarVisibility(key)
            } else {
                Log.e(Constant.TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    fun setHideNavigationBarItems(key: Int) {
        try {
            val basicOpt = MainActivity.basicOptV2
            if (basicOpt != null) {
                basicOpt.setHideNavigationBarItems(key)
            } else {
                Log.e(Constant.TAG, "basicOptV2 is null")
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

}