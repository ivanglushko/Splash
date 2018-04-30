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
    // FIXME: скобочки + сделай работу с таблицей как в модуле Feed и все заработает. Этот urls вообще не нужен в таком виде
    var urls: [String]? {get set}
    func reloadData()
}
// FIXME: скобочки
protocol SettingsViewOutput: class{
    func tappedOnLink(index: Int)
    func triggerViewReadyEvent()
    func returnUrls() -> [String]?

    func triggerAddNewLinkAction(urlString: String?)
}
