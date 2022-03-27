//
//  AppDelegate.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@main
final class AppDelegate: UIResponder {}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureKeyboard()
        FirebaseApp.configure()
        return true
    }
    
    // MARK: UISceneSession lifecycle
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
}

// MARK: - Private functions
private extension AppDelegate {
    func configureKeyboard() {
        IQKeyboardManager.shared.enable                        = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder  = false
        IQKeyboardManager.shared.enableAutoToolbar             = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside    = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30
    }
}
