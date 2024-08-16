import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {

  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

}
