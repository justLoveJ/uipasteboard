import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'uipasteboard_platform_interface.dart';

/// An implementation of [UipasteboardPlatform] that uses method channels.
class MethodChannelUipasteboard extends UipasteboardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('uipasteboard');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
