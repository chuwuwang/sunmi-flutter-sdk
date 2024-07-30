package com.sunmi.flutter.sdk.card

data class CardInfo(
    var cardType: String = "",
    var cardNumber: String = "",
    var expireDate: String = "",
    var serviceCode: String = "",
    var cardholderName: String = "",
    var cardSerialNumber: String = "",
    var atr: String = "",
    var ats: String = "",
    var uuid: String = "",
    var track1: String = "",
    var track2: String = "",
    var track3: String = "",
    var fallback: Boolean = false,
)