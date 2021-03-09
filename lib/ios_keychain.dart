import 'dart:async';

import 'package:flutter/services.dart';

class IOSKeychain {
  static const MethodChannel _channel = const MethodChannel('ios_keychain');

  static Future<String> read(String key) async {
    return await _channel.invokeMethod('readKey', {"key": key});
  }

  static Future<bool> update(String key, String value) async {
    return await _channel.invokeMethod('updateKey', {"key": key, "value": value});
  }

  static Future<bool> write(String key, String value) async {
    return await _channel.invokeMethod('writeKey', {"key": key, "value": value});
  }

  static Future<bool> remove(String key) async {
    return await _channel.invokeMethod('removeKey', {"key": key});
  }
}
