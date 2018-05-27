//
//  AppDelegate.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?

}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.isStatusBarHidden = true
        window = UIWindow()
        window?.makeKeyAndVisible()

        let storyboardViewControllerName = "InitialViewController"
        let storyboard = UIStoryboard(name: storyboardViewControllerName, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: storyboardViewControllerName)
        window?.rootViewController = initialViewController

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataHelper.shared.save()
    }
}

