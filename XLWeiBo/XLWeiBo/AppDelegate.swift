//
//  AppDelegate.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 设置应用程序额外信息
        setupAppAdditions()
        
        // 设置启动
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = XLMainTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

// MARK: - 设置应用程序额外信息
extension AppDelegate {
    private func setupAppAdditions() {
        // 设置 SVProgressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        // 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        // 获取用户授权通知（上方的提示条、声音、数字）
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (success, error) in
                print("授权 " + (success ? "成功" : "失败"))
            }
        } else {
            let notiSettings = UIUserNotificationSettings(types: [.alert, .badge, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notiSettings)
        }
    }
}

