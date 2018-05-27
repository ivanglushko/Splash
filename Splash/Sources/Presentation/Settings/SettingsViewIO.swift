//
//  SettingsViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol SettingsViewInput: class {
    func reloadData()
}

protocol SettingsViewOutput: class {
    func createChannel(url: String)
    func deleteAllChannels()
    func numberOfRows() -> Int
    func url(for indexPath: IndexPath) -> String?
    func tapLink(with index: Int)
    func triggerViewReadyEvent()
}
