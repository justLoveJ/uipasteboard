import 'package:flutter/services.dart';

final _channel = const MethodChannel('uipasteboard');

abstract class UIPasteboard {
  factory UIPasteboard() => const _UIPasteboardImpl();

  Future<int> getChangeCount();

  Future<int> getNumberOfItems();

  Future<bool> hasColors();

  Future<Color?> getColor();

  Future<List<Color>?> getColors();

  Future<bool> hasImages();

  Future<ByteData?> getImage();

  Future<List<ByteData>?> getImages();

  Future<bool> hasURLs();

  Future<String?> getURL();

  Future<List<String>?> getURLs();

  Future<bool> hasStrings();

  Future<String?> getString();

  Future<List<String>?> getStrings();
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
}

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  if (hexCode.length == 6) {
    hexColor = 'FF$hexCode';
  }

  return Color(int.parse(hexColor, radix: 16));
}
