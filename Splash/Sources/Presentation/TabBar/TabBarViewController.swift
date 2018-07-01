//
//  TabBarViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit
import ChameleonFramework

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //runThis()
        setup()
    }
    func runThis() {
        
//        let feedNavControllerX = UINavigationControllerX(rootViewController: FeedTableViewController())
//        let blogNavControllerX = UINavigationControllerX(rootViewController: BlogTableViewController())
//        let settingsNavControllerX = UINavigationControllerX(rootViewController: SettingsTableViewController())
        
        let feedNavControllerX = UIStoryboard(name: "FeedViewController", bundle: nil).instantiateInitialViewController()!
        let blogNavControllerX = UIStoryboard(name: "BlogViewController", bundle: nil).instantiateInitialViewController()!
        let settingsNavControllerX = UIStoryboard(name: "SettingsViewController", bundle: nil).instantiateInitialViewController()!
        
        feedNavControllerX.title = "Feed"
        feedNavControllerX.tabBarItem.image = UIImage(named: "cloudIcon")
        blogNavControllerX.title = "Blog"
        blogNavControllerX.tabBarItem.image = UIImage(named: "blogIcon")
        settingsNavControllerX.title = "Settings"
        settingsNavControllerX.tabBarItem.image = UIImage(named: "settingsIcon")
        
        self.viewControllers = [
            feedNavControllerX,
            blogNavControllerX,
            settingsNavControllerX
        ]
    }
    func setup() {
                self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = GradientColor(.leftToRight, frame: self.tabBar.frame, colors: [
            .paleGreen,
            .oceanBlue
            ]
        )
        self.tabBar.tintColor = .oceanBlue
        self.tabBar.unselectedItemTintColor = .oceanBlueDark
    }
}

