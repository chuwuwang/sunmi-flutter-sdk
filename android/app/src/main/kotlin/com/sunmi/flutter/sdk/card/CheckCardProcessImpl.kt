package com.sunmi.flutter.sdk.card

import android.os.Bundle
import com.sunmi.flutter.sdk.Constant
import com.sunmi.pay.hardware.aidl.AidlConstants
import com.sunmi.pay.hardware.aidlv2.readcard.ReadCardOptV2

class CheckCardProcessImpl(private val readCardOpt: ReadCardOptV2) {

    var onCheckCardSuccess: (info: CardInfo) -> Unit = { _ -> }
    var onCheckCardFailure: (code: Int, desc: String) -> Unit = { _, _ -> }

    private var allowedFallback = false

    companion object {

        const val CARD_ABSENT = AidlConstants.CardExistStatus.CARD_ABSENT

        const val CARD_PRESENT = AidlConstants.CardExistStatus.CARD_PRESENT

    }

    fun startCheckCard(cardType: Int, timeout: Int = 60, allowedFallback: Boolean) {
        try {
            this.allowedFallback = allowedFallback
            readCardOpt.checkCard(cardType, checkCardCallback, timeout)
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    fun cancelCheckCard() {
        try {
            readCardOpt.cancelCheckCard()
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    fun cardOff(cardType: Int) {
        try {
            readCardOpt.cardOff(cardType)
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    fun getCardExistStatus(cardType: Int): Int {
        var status = -1;
        try {
            status = readCardOpt.getCardExistStatus(cardType)
        } catch (e: Throwable) {
            e.printStackTrace()
        }
        return status
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    private val checkCardCallback = object : CheckCardCallbackWrapper() {

        override fun findMagCard(info: Bundle ? ) {
            super.findMagCard(info)
            if (info != null) {
                magneticCardHandle(info)
            } else {
                onCheckCardFailure(Constant.ERROR_READ_CARD_FAILURE, "Read card failure")
            }
        }

        override fun findRFCardEx(info: Bundle ? ) {
            super.findRFCardEx(info)
            if (info != null) {
                val ats = info.getString("ats") ?: ""
                val uuid = info.getString("uuid") ?: ""
                val cardInfo = CardInfo()
                cardInfo.ats = ats
                cardInfo.uuid = uuid
                cardInfo.cardType = CardType.Contactless.text
                onCheckCardSuccess(cardInfo)
            } else {
                onCheckCardFailure(Constant.ERROR_READ_CARD_FAILURE, "Read card failure")
            }
        }

        override fun findICCardEx(info: Bundle ? ) {
            super.findICCardEx(info)
            if (info != null) {
                val atr = info.getString("atr") ?: ""
                val cardInfo = CardInfo()
                cardInfo.atr = atr
                cardInfo.cardType = CardType.Contact.text
                onCheckCardSuccess(cardInfo)
            } else {
                onCheckCardFailure(Constant.ERROR_READ_CARD_FAILURE, "Read card failure")
            }
        }

        override fun onError(code: Int, message: String ? ) {
            super.onError(code, message)
            onCheckCardFailure(code, message ?: "Read card failure")
        }

    }

    private fun magneticCardHandle(bundle: Bundle) {
        val track1 = bundle.getString("TRACK1")
        val track2 = bundle.getString("TRACK2")
        val track3 = bundle.getString("TRACK3")
        var fallback = false
        var cardInfo = CardInfo()
        if (track2 != null) {
            val chipCard = TrackHelper.isChipCard(track2)
            if (chipCard && allowedFallback == false) {
                onCheckCardFailure(Constant.ERROR_READ_CARD_NOT_ALLOWED_DOWNGRADE, "Please use the chip card reader")
                return
            }
            if (chipCard) {
                fallback = true
            }
            cardInfo = TrackHelper.parseTrack2(track2)
        }
        cardInfo.fallback = fallback
        cardInfo.track1 = track1 ?: ""
        cardInfo.track2 = track2 ?: ""
        cardInfo.track3 = track3 ?: ""
        if (track1 != null) {
            cardInfo.cardholderName = TrackHelper.getCardHolderName(track1)
        }
        if (cardInfo.cardNumber != null && cardInfo.cardNumber.length >= 13 && cardInfo.cardNumber.length <= 19) {
            onCheckCardSuccess(cardInfo)
        } else {
            onCheckCardFailure(Constant.ERROR_READ_CARD_FAILURE, "Read card failure")
        }
    }

}