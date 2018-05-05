//
//  FeedPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

class FeedPresenter {
    weak var view: FeedViewInput?

    private let feedParser = FeedParser()
    private var items: [ArticleItem] = []
}

extension FeedPresenter: FeedViewOutput {
    // MARK: Lifecycle
    func triggerViewReadyEvent() {
        view?.setupInitialState()
        startParsingURLs()
    }

    func triggerViewWillAppearEvent() {
        reloadNewLinkLabel()
    }

    // MARK: User actions
    func triggerAddNewChannelEvent() {
        debugPrint("\(#function) in \(#file) without implementation")
    }

    // MARK: UITableViewDataSource
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func item(for indexPath: IndexPath) -> ArticleItem {
        return items[indexPath.row]
    }

    // MARK: UITableViewDelegate
    func tapArticle(with indexPath: Int) {
        items[indexPath].expanded = !items[indexPath].expanded
        view?.reloadData()
    }
}

// MARK: - Private helpers
private extension FeedPresenter {
    func startParsingURLs() {
        guard let urlsStrings = UserDefaults.standard.value(forKey: "urls") as? [String] else { return }

        if let urlString = urlsStrings.first, let url = URL(string: urlString) {
            DispatchQueue.main.async {
                self.parseURL(url: url)
            }
        }
    }

    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url) { (items) in
            self.didParseURL(with: items)
        }
    }

    func didParseURL(with items: [ArticleItem]) {
        self.items = items
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
