import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';

import 'Core/Helpers/Configuration.dart';
import 'MyApp.dart';

void main() {
  Configuration.environment = Environment.local;
  debugPrint = (String message, {int wrapWidth}) =>
      Utils.debugPrintSynchronouslyWithText(message, wrapWidth: wrapWidth);
  runApp(MyApp());
}
