import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';

import 'Core/Helpers/Configuration.dart';
import 'MyApp.dart';

void main() {
  Configuration.environment = Environment.prod;
  debugPrint = (String message, {int wrapWidth}) {};
  runApp(MyApp());
}
