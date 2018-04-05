//
//  FeedViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol FeedViewInput: class{
    var numberOfCells: Int {get set}
    func updateView()
    func buildButton()
    func setRowHeight()
}

protocol FeedViewOutput: class{
    func triggerViewReadyEvent()
    func parseURL(url: URL)
    func numberOfCells() -> Int
}
