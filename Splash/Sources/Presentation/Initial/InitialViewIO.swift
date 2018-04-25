//
//  InitialViewIO.swift
//  Splash
//
//  Created by Иван Букшев on 04/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol InitialViewInput: class {
    func setupInitialState()
    func openMainScreen()
}

protocol InitialViewOutput: class {
    func triggerViewReadyEvent()
}
