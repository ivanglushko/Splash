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
    private var channel: Channel?
    private var articles: [Article]? {
        let articles = channel?.article?.allObjects as? [Article]
        let sortedArticles = articles?.sorted(by: { return $0.pubDate < $1.pubDate })
        return sortedArticles
    }

}

extension FeedPresenter: FeedViewOutput {
    var numberOfItems: Int { return items.count }
    func setNavigationItemTitle() -> String {
        return channel?.name ?? "Splash"
    }
    // MARK: Lifecycle
    func triggerViewReadyEvent() {
        view?.setupInitialState()
        
    }
    
    func triggerViewWillAppearEvent() {
        channel = {
            let predicate = CoreDataHelper.shared.isCurrentPredicate
            let channelArray =  CoreDataHelper.shared.fetch(entity: "Channel", predicate: predicate) as! [Channel]
            guard let channel = channelArray.first else { return nil }
            print(channel.url)
            return channel
        }()
        
        let isConnectedToNetwork = AppDelegate().isConnectedToNetwork()
        guard isConnectedToNetwork else {
            if let articles = channel?.article?.allObjects, !articles.isEmpty {
                view?.reloadData()
            } else {
                view?.showConnectionError()
            }
            return
        }
        if let _ = channel {
            view?.showLoading()
            startParsingURLs()
        } else {
            items = []
            view?.reloadData()
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
        return articles?.count ?? 0
    }
    
    func article(for indexPath: IndexPath) -> Article? {
        return articles?[indexPath.row]
    }
    
    // MARK: UITableViewDelegate
    func tapArticle(with index: Int) {
        guard let article = articles?[index] else { return }
        article.expanded = !article.expanded
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
        let errorHandler: ((Error?) -> Void) = { err in
            if let _ = err {
                DispatchQueue.main.async {
                    self.items = []
                    self.view?.reloadData()
                    self.view?.showParsingError()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.hideHints()
                    self.view?.reloadData()
                }
            }
        }
        feedParser.parseFeed(feedUrl: url, errorHandler: errorHandler) { (items) in
            print(items.count)
            self.didParseURL(with: items)
            }


    }
    
    func didParseURL(with items: [ArticleItem]) {
        self.items = items
        let name = feedParser.returnChannelName()
        channel?.name = name
        fillArticles()
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
        
    }
    
    func fillArticles() {
        articles?.forEach { CoreDataHelper.shared.delete(object: $0) }
        for item in items {
            let article = Article(context: CoreDataHelper.shared.context)
            article.title = item.title
            article.descriptionString = item.description
            article.pubDate = item.pubDate
            article.expanded = item.expanded
            article.isFavourite = false
            article.id = NSUUID().uuidString
            article.channel = channel
        }
        CoreDataHelper.shared.save()
        print("Stored items after filling", articles?.count as Int!)
    }
    
}
