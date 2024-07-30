package com.sunmi.flutter.sdk.card

import android.util.Log
import java.util.regex.Pattern

object TrackHelper {

    private const val TAG = "card"

    fun parseTrack2(track2: String): CardInfo {
        val cardInfo = CardInfo()
        cardInfo.track2 = track2
        if (track2 == null || track2.length < 13) {
            return cardInfo
        }
        val validTrack2 = filterTrack(track2)
        var index = validTrack2.indexOf("=")
        if (index == -1) {
            index = validTrack2.indexOf("D")
        }
        if (index == -1) {
            return cardInfo
        }
        var cardNo = ""
        if (validTrack2.length > index) {
            cardNo = validTrack2.substring(0, index)
        }
        var expireDate = ""
        if (validTrack2.length > index + 5) {
            expireDate = validTrack2.substring(index + 1, index + 5)
        }
        var serviceCode = ""
        if (validTrack2.length > index + 8) {
            serviceCode = validTrack2.substring(index + 5, index + 8)
        }
        cardInfo.cardNumber = cardNo
        cardInfo.expireDate = expireDate
        cardInfo.serviceCode = serviceCode
        Log.e(TAG, "cardNo: $cardNo expireDate: $expireDate serviceCode: $serviceCode")
        return cardInfo
    }

    /**
     * 服务代码(SC)第一位
     * 如果卡片仅含有磁条, 不含有芯片, 那么服务码仅可以是1或5开头
     * 如果卡片含有芯片, 那么服务码仅可以是2或6开头
     */
    fun isChipCard(track2: String): Boolean {
        if (track2 == null || track2.length < 13) {
            return false
        }
        val index = track2.indexOf("=")
        if (index < 0) {
            return false
        }
        val serviceCode = track2.substring(index + 5, index + 6)
        return "2" == serviceCode || "6" == serviceCode
    }

    @JvmStatic
    fun getCardHolderName(track1: String): String {
        var cardHolderName = ""
        if (track1 != null && track1.length > 0) {
            val list = track1.split("\\^")
            if (list.size >= 2) {
                var string = list[1]
                val index = string.indexOf("/")
                if (index != -1) {
                    string = string.substring(0, index)
                }
                cardHolderName = string
            }
        }
        Log.e(TAG, "cardHolderName: $cardHolderName")
        return cardHolderName
    }

    @JvmStatic
    fun filterTrack(track2: String): String {
        val regex = "[^0-9=D]"
        val pattern = Pattern.compile(regex)
        val matcher = pattern.matcher(track2)
        return matcher.replaceAll("").trim()
    }

}