//
//  AppDelegate.swift
//  CustomTabBar
//
//  Created by 陈嘉琳 on 2020/8/26.
//  Copyright © 2020 CJL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

     var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let home = HomeTabBarController()
        self.window?.rootViewController = home
        self.window?.makeKeyAndVisible()
    
        return true
    }

    

}

