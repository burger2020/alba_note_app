import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
//     var result = false
//
//     if url.absoluteString.hasPrefix("kakao"){
//         result = super.application(app, open: url, options: options)
//     }
//     if !result {
//         result = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
//     }
//
//      return result

//     NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
