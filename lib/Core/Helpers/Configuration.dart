import 'package:messaging_demo_flutter/Core/Helpers/ApiEndpoints.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';

class Configuration {
  static Environment environment = Environment.local;

  static String getBaseUrl() {
    switch (environment) {
      case Environment.local:
        return ApiEndpoints.LocalBaseURL;
        break;
      case Environment.staging:
        return ApiEndpoints.StagingBaseURL;
        break;
      case Environment.prod:
        return ApiEndpoints.ProdBaseURL;
        break;
      default:
        return ApiEndpoints.LocalBaseURL;
        break;
    }
  }
}
