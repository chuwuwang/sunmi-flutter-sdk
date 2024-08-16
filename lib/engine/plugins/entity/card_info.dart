class CardInfo {

  String cardType = "";
  String cardNumber = "";
  String expireDate = "";
  String serviceCode = "";
  String cardholderName = "";
  String cardSerialNumber = "";
  String atr = "";
  String ats = "";
  String uuid = "";
  String track1 = "";
  String track2 = "";
  String track3 = "";
  bool fallback = false;

  CardInfo();

  CardInfo.fromJson(Map<String, dynamic> json) {
    cardType = json["cardType"] ?? "";
    cardNumber = json["cardNumber"] ?? "";
    expireDate = json["expireDate"] ?? "";
    serviceCode = json["serviceCode"] ?? "";
    cardholderName = json["cardholderName"] ?? "";
    cardSerialNumber = json["cardSerialNumber"] ?? "";
    atr = json["atr"] ?? "";
    ats = json["ats"] ?? "";
    uuid = json["uuid"] ?? "";
    track1 = json["track1"] ?? "";
    track2 = json["track2"] ?? "";
    track3 = json["track3"] ?? "";
    fallback = json["fallback"] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["cardType"] = cardType;
    map["cardNumber"] = cardNumber;
    map["expireDate"] = expireDate;
    map["serviceCode"] = serviceCode;
    map["cardholderName"] = cardholderName;
    map["cardSerialNumber"] = cardSerialNumber;
    map["atr"] = atr;
    map["ats"] = ats;
    map["uuid"] = uuid;
    map["track1"] = track1;
    map["track2"] = track2;
    map["track3"] = track3;
    map["fallback"] = fallback;
    return map;
  }

}
