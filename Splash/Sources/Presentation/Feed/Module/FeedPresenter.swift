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
    
    private let urls = UserDefaults.standard.value(forKey: "urls") as? [String]
    private let feedParser = FeedParser()
    private var items: [ArticleItem] = []
}

// MARK: - FeedViewOutput
extension FeedPresenter: FeedViewOutput {
    func triggerViewReadyEvent() {
        view?.setupInitialState()
        if let urls = urls, let urlString = urls.first, let url = URL(string: urlString) {
            print("if let urls")
            parseURL(url: url)
        }
        print("TriggerViewReadyEvent")
    }
    
    func triggerViewWillAppearEvent() {
        reloadNewLinkButton()
    }
    
    func triggerAddNewChannelEvent() {
        // Здесь логика того, что делать когда нажмем добавить новую ссылку на новостной канал
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
    
    func tapArticle(with indexPath: IndexPath) {
        debugPrint("\(#function) in \(#file) without implementation")
    }
}

// MARK: - Logic
private extension FeedPresenter {
    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url) { (items) in
            self.items = items
            print("parseURL")
            assert(self.items.isEmpty == false)
            self.reloadNewLinkButton()
            self.view?.reloadData()
        }
    }
    
    func reloadNewLinkButton() {
        if items.isEmpty {
            print("items.isEmpty")
            view?.showNewLinkButton()
        } else {
            print("items.notEmpty")
            print(items.first)
            OperationQueue.main.addOperation {
                self.view?.hideNewLinkButton()
            }
        }
    }
}
