import 'package:flutter/services.dart';

class CheckCardProcessorEngine {

  static const MethodChannel _channel = MethodChannel("check-card-processor-engine");

  static Future<String> startCheckCard(int cardType, timeout) async {
    var parameter = {};
    parameter["timeout"] = timeout;
    parameter["cardType"] = cardType;
    return await _channel.invokeMethod("startCheckCard", parameter);
  }

  static void stopCheckCard() async {
    await _channel.invokeMethod("stopCheckCard");
  }

}
