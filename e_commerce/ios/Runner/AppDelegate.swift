import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller = window?.rootViewController as! FlutterViewController
    let deviceChannel = FlutterMethodChannel(name: "com.example.device/info",
                                             binaryMessenger: controller.binaryMessenger)
    
    deviceChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getDeviceInfo" {
        let device = UIDevice.current
        let deviceInfo: [String: String] = [
          "name": device.name,
          "systemName": device.systemName,
          "systemVersion": device.systemVersion,
          "model": device.model
        ]
        result(deviceInfo)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
