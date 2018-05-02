//
//  SettingsViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol SettingsViewInput: class {
    var urls: [String]? {get set}
    func reloadData()
}

protocol SettingsViewOutput: class {
    func tappedOnLink(index: Int)
    func triggerViewReadyEvent()
    func returnUrls() -> [String]?
}
