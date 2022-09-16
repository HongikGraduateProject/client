//
//  AppDelegate.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()
        
        if let user = Auth.auth().currentUser {
            print("You're sign in as \(user.uid), email: \(user.email ?? "")")
        }
                 
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
