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

        // Заметил, что urls вызывается только тут, поэтому перенес сюда
        guard let urlsStrings = UserDefaults.standard.value(forKey: "urls") as? [String] else { return }
        if let urlString = urlsStrings.first, let url = URL(string: urlString) {
            parseURL(url: url)
        }
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
        // Убрал всю портянку в отдельный метод для лучшего понимания
        feedParser.parseFeed(feedUrl: url) { (items) in
            self.didParseURL(with: items)
        }
    }

    func didParseURL(with items: [ArticleItem]) {
        self.items = items
        // Что такое assert? Расскажи-ка :)
        // assert(self.items.isEmpty == false)
        self.reloadNewLinkButton()
        self.view?.reloadData()
    }
    
    func reloadNewLinkButton() {
        if items.isEmpty {
            view?.showNewLinkButton()
        } else {
            view?.hideNewLinkButton()
        }
    }
}
