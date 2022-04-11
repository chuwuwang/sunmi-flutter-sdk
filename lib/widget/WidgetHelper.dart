import 'package:flutter/material.dart';

class WidgetHelper {

  static itemWidget(String text, bool rightIcon, VoidCallback onPressed) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Stack(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: [
                Expanded(child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 16), ), ),
                if (rightIcon) const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 55, 0, 0),
            child: const Divider(height: 1, color: Colors.black26),
          )
        ],
      ),
    );
  }

}