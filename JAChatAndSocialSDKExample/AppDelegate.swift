//
//  AppDelegate.swift
//  JASocialModuleExample
//
//  Created by 张嘉诚 on 2024/2/29.
//

import UIKit
import AmityUIKit
import HyphenateChat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // appkey 替换成你在环信即时通讯 IM 管理后台注册应用中的 App Key
        let options = EMOptions(appkey: "<#appkey#>")
        // apnsCertName是证书名称，可以先传 nil，等后期配置 APNs 推送时在传入证书名称
        options.apnsCertName = nil
        EMClient.shared().initializeSDK(with: options)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns
        // Forward Tokens to Your Provider Server
        AmityUIKitManager.unregisterDevicePushNotification()
        
        // Transform deviceToken into a raw string, before sending to AmitySDK server.
        let tokenParts: [String] = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let tokenString: String = tokenParts.joined()
        
        UserDefaults.standard.setValue(tokenString, forKey: "deviceToken")
        AmityUIKitManager.registerDeviceForPushNotification(tokenString)
    }

}

