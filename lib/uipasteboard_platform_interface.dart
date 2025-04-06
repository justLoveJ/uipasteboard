import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uipasteboard_method_channel.dart';

abstract class UipasteboardPlatform extends PlatformInterface {
  /// Constructs a UipasteboardPlatform.
  UipasteboardPlatform() : super(token: _token);

  static final Object _token = Object();

  static UipasteboardPlatform _instance = MethodChannelUipasteboard();

  /// The default instance of [UipasteboardPlatform] to use.
  ///
  /// Defaults to [MethodChannelUipasteboard].
  static UipasteboardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UipasteboardPlatform] when
  /// they register themselves.
  static set instance(UipasteboardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
