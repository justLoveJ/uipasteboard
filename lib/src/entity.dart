abstract class UIPasteboard {
  static UIPasteboard get general => _UIPasteboardImpl();

  Future<int> getChangeCount();

  Future<bool> hasColors();

  Future<bool> hasImages();

  Future<bool> hasURLs();

  Future<bool> hasStrings();
}

class _UIPasteboardImpl implements UIPasteboard {
  @override
  Future<int> getChangeCount() {
    // TODO: implement getChangeCount
    throw UnimplementedError();
  }

  @override
  Future<bool> hasColors() {
    // TODO: implement hasColors
    throw UnimplementedError();
  }

  @override
  Future<bool> hasImages() {
    // TODO: implement hasImages
    throw UnimplementedError();
  }

  @override
  Future<bool> hasStrings() {
    // TODO: implement hasStrings
    throw UnimplementedError();
  }

  @override
  Future<bool> hasURLs() {
    // TODO: implement hasURLs
    throw UnimplementedError();
  }
}
