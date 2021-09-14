//
//  AppDelegate.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let splash = SplashRouter.createModule()

        let navigationController = UINavigationController()
        navigationController.viewControllers = [splash]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

