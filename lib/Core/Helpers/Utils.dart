import 'package:flutter/foundation.dart';

class Utils {
  static bool isValidURL(String url) {
    return Uri.parse(url).isAbsolute;
  }

  static void log(String screen, String tag, String msg) {
    debugPrint("Screen : $screen -- Tag : $tag -- Message : $msg");
  }

  static void debugPrintSynchronouslyWithText(String message, {int wrapWidth}) {
    message = "[${DateTime.now()}]: $message";
    debugPrintSynchronously(message, wrapWidth: wrapWidth);
  }
}
