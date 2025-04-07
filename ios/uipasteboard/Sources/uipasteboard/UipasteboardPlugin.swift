import Flutter
import UIKit

private let channel = "ui_pasteboard"

public class UiPasteboardPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channel, binaryMessenger: registrar.messenger())
    let instance = UiPasteboardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getURLs":
      getURLs(call, result)
      return
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getURLs(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    let pasteboard = getPasteboard(name: args["name"] as? String)
    if let urls = pasteboard.urls {
      result(urls.map { $0.absoluteString })
    } else {
      result(nil)
    }
  }

  private func hasURLs(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    let pasteboard = getPasteboard(name: args["name"] as? String)
    if pasteboard.hasURLs {
      result(true)
    } else {
      result(false)
    }
  }

  private func hasImages(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    let pasteboard = getPasteboard(name: args["name"] as? String)
    if pasteboard.hasImages {
      result(true)
    } else {
      result(false)
    }
  }
  
  private func hasStrings(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    let pasteboard = getPasteboard(name: args["name"] as? String)
    if pasteboard.hasStrings {
      result(true)
    } else {
      result(false)
    }
  }

  private func hasColors(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    let pasteboard = getPasteboard(name: args["name"] as? String)
    if pasteboard.hasColors {
      result(true)
    } else {
      result(false)
    }
  }
}

private func getPasteboard(name: String?) -> UIPasteboard {
  if name == nil || name == UIPasteboard.general.name.rawValue {
    return UIPasteboard.general
  }
  return UIPasteboard(name: UIPasteboard.Name(rawValue: name), create: true)
      ?? UIPasteboard.general
}
