import 'dart:async';

import 'package:flutter/services.dart';

class TencentMap {
  static const MethodChannel _channel =
      const MethodChannel('tencent_map');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
