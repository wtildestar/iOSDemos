//
//  AppDelegate.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        FirebaseApp.configure()
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = UINavigationController(rootViewController: WebKitViewController())
//        self.window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
    }
}

