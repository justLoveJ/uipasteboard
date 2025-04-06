import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uipasteboard_method_channel.dart';

abstract class UiPasteboardPlatform extends PlatformInterface {
  /// Constructs a UiPasteboardPlatform.
  UiPasteboardPlatform() : super(token: _token);

  static final Object _token = Object();

  static UiPasteboardPlatform _instance = MethodChannelUiPasteboard();

  /// The default instance of [UiPasteboardPlatform] to use.
  ///
  /// Defaults to [MethodChannelUiPasteboard].
  static UiPasteboardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UiPasteboardPlatform] when
  /// they register themselves.
  static set instance(UiPasteboardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
