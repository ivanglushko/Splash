//
//  FeedViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol FeedViewInput: class {
    func setupInitialState()
    func reloadData()
    func showHints()
    func showConnectionError()
    func showParsingError()
    func showLoading()
    func hideHints()
}

protocol FeedViewOutput: class {
    var numberOfItems: Int {get}
    func setNavigationItemTitle() -> String
    
    // Lifecycle
    func triggerViewReadyEvent()
    func triggerViewWillAppearEvent()
    
    // User actions
    func triggerAddNewChannelEvent()
    
    // UITableViewDataSource
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func article(for indexPath: IndexPath) -> Article?
    
    // UITableViewDelegate
    func tapArticle(with index: Int)
}
