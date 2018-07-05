//
//  UINavigationBarX.swift
//  Splash
//
//  Created by Ivan Glushko on 02.06.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit
import ChameleonFramework

class UINavigationControllerX: UINavigationController {
    let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.paleGreenDark ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .paleGreen
        self.navigationBar.largeTitleTextAttributes = textAttributes
    }
}
