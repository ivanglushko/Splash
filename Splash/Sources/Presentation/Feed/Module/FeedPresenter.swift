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
    private var storedItems: [Article] = []
    private var channel: Channel? = {
        let predicate = CoreDataHelper.shared.isCurrentPredicate
        let channelArray =  CoreDataHelper.shared.fetch(entity: "Channel", predicate: predicate) as! [Channel]
        guard let channel = channelArray.first else { return nil }
        print(channel.url)
        return channel
    }()
}

extension FeedPresenter: FeedViewOutput {
    // MARK: Lifecycle
    func triggerViewReadyEvent() {
        view?.setupInitialState()
        startParsingURLs()
    }
    
    func triggerViewWillAppearEvent() {
        if let _ = channel {
            view?.showLoading()
        } else {
            view?.showHints()
        }
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
        DispatchQueue.main.async { self.view?.reloadData() }
    }
}

// MARK: - Private helpers
private extension FeedPresenter {
    func startParsingURLs() {
        if let urlString = channel?.url , let url = URL(string: urlString) {
            DispatchQueue.main.async { self.parseURL(url: url) }
        }
    }
    
    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url) { (items) in
            print(items.count)
            self.didParseURL(with: items)
            }

    }
    
    func didParseURL(with items: [ArticleItem]) {
        self.items = items
        channel?.name = feedParser.returnChannelName()
        print(channel?.name ?? "no name")
        fillStoredItems()
        self.reloadNewLinkLabel()
    }
    
    func reloadNewLinkLabel() {
            if items.isEmpty {
                DispatchQueue.main.async {
                    self.view?.showParsingError()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.hideHints()
                    self.view?.reloadData()
                }
            }
        }
    
    func fillStoredItems() {
        for item in items {
            let article = Article(context: CoreDataHelper.shared.context)
            article.title = item.title
            article.descriptionString = item.description
            article.pubDateString = item.pubDateString
            article.expanded = item.expanded
            article.isFavourite = false
            article.id = NSUUID().uuidString
            article.channel = channel
        }
        CoreDataHelper.shared.save()
        storedItems = CoreDataHelper.shared.fetch(entity: "Article") as! [Article]
        deleteAllArticles()
        print("Stored items after filling",storedItems.count)
    }
    
    func deleteAllArticles() {
        CoreDataHelper.shared.deleteAll(fetchRequest: Article.fetchRequest())
        storedItems = CoreDataHelper.shared.fetch(entity: "Article") as! [Article]
        print("Stored items after delete",storedItems.count)
    }
}
