import Flutter
import UIKit

private let channel = "uipasteboard"

public class UIPasteboardPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channel, binaryMessenger: registrar.messenger())
    let instance = UIPasteboardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getChangeCount":
      getChangeCount(call, result)
      return
    case "getNumberOfItems":
      getNumberOfItems(call, result)
      return
    case "getURLs":
      getURLs(call, result)
      return
    case "getURL":
      getURL(call, result)
      return
    case "hasURLs":
      hasURLs(call, result)
      return
    case "getImage":
      getImage(call, result)
      return
    case "getImages":
      getImages(call, result)
      return
    case "hasImages":
      hasImages(call, result)
      return
    case "getString":
      getString(call, result)
      return
    case "getStrings":
      getStrings(call, result)
      return
    case "hasStrings":
      hasStrings(call, result)
      return
    case "hasColors":
      hasColors(call, result)
      return
    case "getColor":
      getColor(call, result)
      return
    case "getColors":
      getColors(call, result)
      return
    case "getItems":
      getItems(call, result)
      return
    case "getTypes":
      getTypes(call, result)
      return
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getChangeCount(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    result(UIPasteboard.general.changeCount)
  }

  private func getNumberOfItems(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    result(UIPasteboard.general.numberOfItems)
  }

  private func getURL(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let url = UIPasteboard.general.url {
      result(url.absoluteString)
    } else {
      result(nil)
    }
  }

  private func getURLs(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let urls = UIPasteboard.general.urls {
      result(urls.map { $0.absoluteString })
    } else {
      result(nil)
    }
  }

  private func hasURLs(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if #available(iOS 14.0, *) {
      // iOS 14+ 使用新的检测 API
        UIPasteboard.general.detectPatterns(for: [.probableWebURL, .probableWebSearch]) { callbackresult in
            switch callbackresult {
            case let .success(pattern):
                if pattern.contains(.probableWebURL) {
                    // 识别剪贴板中的内容
                    result(true)
                }else {
                    result(false)
                }
            case let .failure(error):
                result(false)
            }
        }
    } else {
        result(UIPasteboard.general.hasURLs)
    }
  }

  private func hasImages(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if UIPasteboard.general.hasImages {
      result(true)
    } else {
      result(false)
    }
  }

  private func getImage(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let image = UIPasteboard.general.image, let imageData = image.pngData() {
      result(FlutterStandardTypedData(bytes: imageData))
    } else {
      result(nil)
    }
  }

  private func getImages(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let images = UIPasteboard.general.images {
      var imageDataList: [FlutterStandardTypedData] = []
      for image in images {
        if let imageData = image.pngData() {
          imageDataList.append(FlutterStandardTypedData(bytes: imageData))
        }
      }
      result(imageDataList)
    } else {
      result(nil)
    }
  }

  private func hasStrings(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if UIPasteboard.general.hasStrings {
      result(true)
    } else {
      result(false)
    }
  }

  private func getString(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let string = UIPasteboard.general.string {
      result(string)
    } else {
      result(nil)
    }
  }

  private func getStrings(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let strings = UIPasteboard.general.strings {
      result(strings)
    } else {
      result(nil)
    }
  }

  private func hasColors(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if UIPasteboard.general.hasColors {
      result(true)
    } else {
      result(false)
    }
  }

  private func getColors(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let colors = UIPasteboard.general.colors {
      var colorList: [String] = []
      for color in colors {
        colorList.append(color.toHexString())
      }
      result(colorList)
    } else {
      result(nil)
    }
  }

  private func getColor(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    if let color = UIPasteboard.general.color {
      result(color.toHexString())
    } else {
      result(nil)
    }
  }

  private func getItems(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let items = UIPasteboard.general.items
    var itemList: [[String: Any]] = []
    for item in items {
      var itemDict: [String: Any] = [:]
      for (key, value) in item {
        if let data = value as? Data {
          itemDict[key] = FlutterStandardTypedData(bytes: data)
        } else if let string = value as? String {
          itemDict[key] = string
        } else if let url = value as? URL {
          itemDict[key] = url.absoluteString
        }
      }
      itemList.append(itemDict)
    }
    result(itemList)
  }

  private func getTypes(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let types = UIPasteboard.general.types
    result(types)
  }
}

extension UIColor {
  func toHexString() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    getRed(&r, green: &g, blue: &b, alpha: &a)

    let rgb: Int =
      (Int)(r * 255) << 24 | (Int)(g * 255) << 16 | (Int)(b * 255) << 8 | (Int)(a * 255) << 0

    return String(format: "%08x", rgb).uppercased()
  }
}
