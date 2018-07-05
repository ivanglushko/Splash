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
        setup()
    }
    
    func setup() {
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = GradientColor(.leftToRight, frame: self.tabBar.frame, colors: [.paleGreen, .oceanBlue] )
        self.tabBar.tintColor = .oceanBlue
        self.tabBar.unselectedItemTintColor = .oceanBlueDark
    }
}

