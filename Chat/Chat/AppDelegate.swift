//
//  AppDelegate.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: ChatViewController())
        window?.makeKeyAndVisible()
        
        return true
    }


}

