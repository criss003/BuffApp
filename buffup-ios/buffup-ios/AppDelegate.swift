//
//  AppDelegate.swift
//  buffup-ios
//
//  Created by Eleftherios Charitou on 18/09/2019.
//  Copyright © 2019 BuffUp. All rights reserved.
//

import UIKit
import BuffSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupBuffSDK()
        return true
    }
}

extension AppDelegate {
    private func setupBuffSDK() {
        //TODO: Add your SDK initialization logic here if needed
    }
}
