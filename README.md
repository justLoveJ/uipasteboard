# UIPasteboard

[![pub package](https://img.shields.io/pub/v/uipasteboard.svg?style=for-the-badge&logo=dart)](https://pub.dartlang.org/packages/uipasteboard)

A Flutter plugin to interact
with [UIPasteboard](https://developer.apple.com/documentation/uikit/uipasteboard) on iOS.

## Get Started

Add the following in the dependencies section of your `pubspec.yaml`:

```yaml
dependencies:
  uipasteboard: <latest version>
```

```dart
Future<void> main() async {
  // the plugin only works on iOS
  if (Platform.isIOS) {
    final pasteboard = UIPasteboard();
    final hasUrl = await pasteboard.hasURLs();
    // Check if the pasteboard has a URL, to avoid asking for permission dialogs.
    if (hasUrl) {
      // Get the URL from the pasteboard
      final url = await pasteboard.getURL();
      print(url);
    }
  }
}
```