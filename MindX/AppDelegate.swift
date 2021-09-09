//
//  AppDelegate.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/3/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)

        let vc = ViewController()

        let nc = UINavigationController(rootViewController: vc)

        window.rootViewController = nc
        window.makeKeyAndVisible()
        
        self.window = window

        return true
    }
}
