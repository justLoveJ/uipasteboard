# UIPasteboard

[![pub package](https://img.shields.io/pub/v/uipasteboard.svg?style=for-the-badge&logo=dart)](https://pub.dev/packages/uipasteboard)

A Flutter plugin to interact
with [UIPasteboard](https://developer.apple.com/documentation/uikit/uipasteboard) on iOS.

> [!IMPORTANT]
> Starting in iOS 14, the system notifies the user when an app gets general pasteboard content that
> originates in a different app without user intent. The system determines user intent based on user
> interactions, such as tapping a system-provided control or pressing Command-V. Use detection
> methods
> this package provided like `UIPasteboard().hasURLs()` to determine whether pasteboard items match
> various patterns, such as web search terms, URLs, or numbers, without notifying the user.

## Get Started

Add the following in the dependencies section of your `pubspec.yaml`:

```yaml
dependencies:
  uipasteboard: <latest version>
```

You can detect if the clipboard contains a URL and retrieve it with the following code:

```dart
Future<void> main() async {
  // Ensure the platform channel was initialized
  WidgetsFlutterBinding.ensureInitialized();

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

## Detection and Retrieval

|  Type  |   Detection    |           Retrieval            |
|:------:|:--------------:|:------------------------------:|
| String | `hasStrings()` | `getString()`,` getStrings()`  |
|  URL   |  `hasURLs()`   |    `getURL()`,` getURLs()`     |
| Image  | `hasImages()`  |  `getImage()`,` getImages()`   |
| Color  | `hasColors()`  |  `getColor()`,` getColors()`   |
