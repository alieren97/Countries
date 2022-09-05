//
//  AppDelegate.swift
//  Countries
//
//  Created by Ali Eren on 1.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?)
    -> Bool {

    
        self.window = self.window ?? UIWindow()
        
        // Create a ViewController object and set it as self.window's root view controller.
        self.window!.rootViewController = MainTabBarViewController()
        
        // Make the window be visible.
        self.window!.makeKeyAndVisible()
        
        return true
    }
}
