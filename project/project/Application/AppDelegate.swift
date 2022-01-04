//
//  AppDelegate.swift
//  project
//
//  Created by Dzmitry on 17.11.21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SignInViewController()
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }

 

}

