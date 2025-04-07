import 'package:flutter/services.dart';

final _channel = const MethodChannel('uipasteboard');

abstract class UIPasteboard {
  factory UIPasteboard() => const _UIPasteboardImpl();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/changecount
  Future<int> getChangeCount();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/numberofitems
  Future<int> getNumberOfItems();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/hasColors
  Future<bool> hasColors();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/color
  Future<Color?> getColor();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/colors
  Future<List<Color>?> getColors();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/hasImages
  Future<bool> hasImages();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/image
  Future<ByteData?> getImage();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/images
  Future<List<ByteData>?> getImages();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/hasurl
  Future<bool> hasURLs();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/url
  Future<String?> getURL();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/urls
  Future<List<String>?> getURLs();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/strings
  Future<bool> hasStrings();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/string
  Future<String?> getString();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/strings
  Future<List<String>?> getStrings();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/types
  Future<List<String>?> getTypes();

  /// https://developer.apple.com/documentation/uikit/uipasteboard/items
  Future<List<Map<String, dynamic>>?> getItems();
}

class _UIPasteboardImpl implements UIPasteboard {
  const _UIPasteboardImpl();

  @override
  Future<int> getChangeCount() async {
    return await _channel.invokeMethod<int>("getChangeCount") ?? 0;
  }

  @override
  Future<int> getNumberOfItems() async {
    return await _channel.invokeMethod<int>("getNumberOfItems") ?? 0;
  }

  @override
  Future<bool> hasColors() async {
    return await _channel.invokeMethod<bool>("hasColors") ?? false;
  }

  @override
  Future<bool> hasImages() async {
    return await _channel.invokeMethod<bool>("hasImages") ?? false;
  }

  @override
  Future<bool> hasStrings() async {
    return await _channel.invokeMethod<bool>("hasStrings") ?? false;
  }

  @override
  Future<bool> hasURLs() async {
    return await _channel.invokeMethod<bool>("hasURLs") ?? false;
  }

  @override
  Future<Color?> getColor() async {
    final hex = await _channel.invokeMethod<String>("getString");
    return hex == null ? null : _colorFromHex(hex);
  }

  @override
  Future<List<Color>?> getColors() async {
    final colors = await _channel.invokeMethod<List<String>>("getColors");
    return colors?.map(_colorFromHex).toList();
  }

  @override
  Future<ByteData?> getImage() async {
    return await _channel.invokeMethod<ByteData>("getImage");
  }

  @override
  Future<List<ByteData>?> getImages() async {
    return await _channel.invokeMethod<List<ByteData>>("getImages");
  }

  @override
  Future<String?> getString() async {
    return await _channel.invokeMethod<String>("getString");
  }

  @override
  Future<List<String>?> getStrings() async {
    return await _channel.invokeMethod<List<String>>("getStrings");
  }

  @override
  Future<String?> getURL() async {
    return await _channel.invokeMethod<String>("getURL");
  }

  @override
  Future<List<String>?> getURLs() async {
    return await _channel.invokeMethod<List<String>>("getURLs");
  }

  @override
  Future<List<Map<String, dynamic>>?> getItems() async {
    return await _channel.invokeMethod<List<Map<String, dynamic>>>("getItems");
  }

  @override
  Future<List<String>?> getTypes() async {
    return await _channel.invokeMethod<List<String>>("getTypes");
  }
}

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  if (hexCode.length == 6) {
    hexColor = 'FF$hexCode';
  }

  return Color(int.parse(hexColor, radix: 16));
}
