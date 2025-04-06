
import 'uipasteboard_platform_interface.dart';

class Uipasteboard {
  Future<String?> getPlatformVersion() {
    return UipasteboardPlatform.instance.getPlatformVersion();
  }
}
