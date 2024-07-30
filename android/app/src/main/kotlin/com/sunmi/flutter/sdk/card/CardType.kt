package com.sunmi.flutter.sdk.card

enum class CardType(val value: Int, val text: String) {
    Manual(0, "Manual"),
    Magnetic(1, "MagneticStripe"),
    Contact(2, "Contact"),
    Contactless(4, "Contactless")
}