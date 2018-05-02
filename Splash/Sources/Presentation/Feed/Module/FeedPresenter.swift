//
//  FeedPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

// MARK: - FeedPresenter
class FeedPresenter {
    weak var view: FeedViewInput?

    private let feedParser = FeedParser()
    private var items: [ArticleItem] = []
}

// MARK: - FeedViewOutput
extension FeedPresenter: FeedViewOutput {
    func triggerViewReadyEvent() {
        view?.setupInitialState()
        guard let urlsStrings = UserDefaults.standard.value(forKey: "urls") as? [String] else { return }
        if let urlString = urlsStrings.first, let url = URL(string: urlString) {
            DispatchQueue.main.async {
                self.parseURL(url: url)
            }
            
        }
        
        print("Items after parsing \(items.count)")
    }
    
    func triggerViewWillAppearEvent() {
        reloadNewLinkLabel()
    }
    
    func triggerAddNewChannelEvent() {
        debugPrint("\(#function) in \(#file) without implementation")
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func item(for indexPath: IndexPath) -> ArticleItem {
        return items[indexPath.row]
    }
    
    func tapArticle(with indexPath: Int) {
        items[indexPath].expanded = !items[indexPath].expanded
        view?.reloadData()
    }
}

// MARK: - Logic
private extension FeedPresenter {
    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url) { (items) in
            print("Started parsing")
            self.didParseURL(with: items)
        }
    }

    func didParseURL(with items: [ArticleItem]) {
        self.items = items
        assert(self.items.isEmpty == false)
        print("Items in closure passed to self.items \(self.items.count)")
        self.reloadNewLinkLabel()
    }
    
    func reloadNewLinkLabel() {
        if items.isEmpty {
            view?.showHints()
        } else {
            view?.hideHints()
            view?.reloadData()
        }
    }
}
