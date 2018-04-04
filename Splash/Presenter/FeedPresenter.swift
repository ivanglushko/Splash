//
//  FeedPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

class FeedPresenter {
    
    weak var view: FeedView?
    weak var settingsView: SettingsView?
    fileprivate let urls = UserDefaults.standard.value(forKey: "urls") as? [String]
    fileprivate let feedParser = FeedParser()
    fileprivate var items: [ArticleItem]? = []
    
    
    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url) { (items: [ArticleItem]) in
            self.items = items
            self.view?.updateView()
        }
    }
    
    
    func numberOfCells() -> Int {
        let number =  items?.count ?? 0
        if number == 0 { view?.buildButton() }
        return number
    }
    
    func returnUrls() -> [String]? {
        return urls
    }
}
