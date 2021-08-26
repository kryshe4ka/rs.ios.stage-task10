//
//  AppDelegate.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 25.08.21.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ProcessViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

