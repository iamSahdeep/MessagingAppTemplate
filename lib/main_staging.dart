import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';

import 'Core/Helpers/Configuration.dart';
import 'Core/Helpers/Utils.dart';
import 'MyApp.dart';

void main() {
  Configuration.environment = Environment.staging;
  debugPrint = (String message, {int wrapWidth}) =>
      Utils.debugPrintSynchronouslyWithText(message, wrapWidth: wrapWidth);
  runApp(MyApp());
}
