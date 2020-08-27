//
//  AppDelegate.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarVC = RootTabBarController.init()
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
        return true
    }


}

