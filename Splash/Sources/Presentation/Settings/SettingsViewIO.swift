//
//  SettingsViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
// FIXME: скобочки
protocol SettingsViewInput: class{
    // FIXME: скобочки
    var urls: [String]? {get set}
    func reloadData()
}
// FIXME: скобочки
protocol SettingsViewOutput: class{
    func tappedOnLink(index: Int)
    func triggerViewReadyEvent()
    func returnUrls() -> [String]?
}
