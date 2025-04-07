import 'package:flutter/services.dart';

final _channel = const MethodChannel('uipasteboard');

abstract class UIPasteboard {
  const UIPasteboard();

  static UIPasteboard get general => _UIPasteboardImpl(name: "general");

  String get name;

  Future<int> getChangeCount();

  Future<bool> hasColors();

  Future<bool> hasImages();

  Future<bool> hasURLs();

  Future<bool> hasStrings();
}

class _UIPasteboardImpl implements UIPasteboard {
  @override
  final String name;

  const _UIPasteboardImpl({required this.name});

  @override
  Future<int> getChangeCount() async {
    return await _channel.invokeMethod<int>("getChangeCount", {"name": name}) ?? 0;
  }

  @override
  Future<bool> hasColors() async {
    return await _channel.invokeMethod<bool>("hasColors", {"name": name}) ?? false;
  }

  @override
  Future<bool> hasImages() async {
    return await _channel.invokeMethod<bool>("hasImages", {"name": name}) ?? false;
  }

  @override
  Future<bool> hasStrings() async {
    return await _channel.invokeMethod<bool>("hasStrings", {"name": name}) ?? false;
  }

  @override
  Future<bool> hasURLs() async {
    return await _channel.invokeMethod<bool>("hasURLs", {"name": name}) ?? false;
  }
}
