package com.sunmi.flutter.sdk.card

import android.os.Bundle
import android.util.Log
import com.sunmi.flutter.sdk.Constant
import com.sunmi.pay.hardware.aidlv2.readcard.CheckCardCallbackV2

open class CheckCardCallbackWrapper : CheckCardCallbackV2.Stub() {

    override fun findMagCard(info: Bundle ? ) {

    }

    override fun findICCard(atr: String ? ) {

    }

    override fun findRFCard(uuid: String ? ) {

    }

    override fun onError(code: Int, message: String ? ) {
        Log.e(Constant.TAG, "code: $code message: $message")
    }

    override fun findICCardEx(info: Bundle ? ) {

    }

    override fun findRFCardEx(info: Bundle ? ) {

    }

    override fun onErrorEx(info: Bundle ? ) {

    }

}
