
import 'dart:async';

import 'package:flutter/services.dart';

class NativeCall {
  static const MethodChannel _channel =
      const MethodChannel('native_call');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
