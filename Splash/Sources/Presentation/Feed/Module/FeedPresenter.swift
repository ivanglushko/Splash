//
//  FeedPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import Reachability
import SystemConfiguration

class FeedPresenter {
    weak var view: FeedViewInput?
    private lazy var reachability = Reachability()
    private let feedParser = FeedParser()
    private var items: [ArticleItem] = []
    private var channel: Channel? {
        let predicate = CoreDataHelper.shared.isCurrentPredicate
        guard let channels =  CoreDataHelper.shared.fetch(entity: "Channel", predicate: predicate) as? [Channel] else { return nil }
        guard let channel = channels.first else { return nil }
        return channel
    }
    private var articles: [Article]? {
        let articles = channel?.articles?.allObjects as? [Article]
        let sortedArticles = articles?.sorted { $0.pubDate < $1.pubDate }
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
        checkConnection()
        
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
        if let urlString = channel?.url, let url = URL(string: urlString) {
            DispatchQueue.main.async { self.parseURL(url: url) }
        }
    }
    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url, errorHandler: { [weak self] (error) in
            if let error = error {
                self?.didFailureParsing(with: error)
            }
        }, completionHandler: { [weak self] (items) in
            self?.didParseURL(with: items)
        })
    }
    func didParseURL(with items: [ArticleItem]) {
        self.items = items
        let name = feedParser.returnChannelName()
        channel?.name = name
        fillArticles()
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideHint()
            self?.view?.reloadData()
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
            article.id = NSUUID().uuidString
            article.channel = channel
        }
        CoreDataHelper.shared.save()
        print("Stored items after filling", articles?.count ?? 0)
    }
    func didFailureParsing(with: Error) {
        DispatchQueue.main.async {
            self.items = []
            self.view?.reloadData()
            self.view?.configureNewLinkLabel(with: NewLinkLabelState.parsingError)
        }
    }
    
    // DELETE LATER ON IF I'LL FIND A BETTER SOLUTION
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
    
    func checkConnection() {
        if isConnectedToNetwork() {
            if channel != nil {
                view?.configureNewLinkLabel(with: NewLinkLabelState.loading)
                startParsingURLs()
            } else {
                items = []
                view?.reloadData()
                view?.showHint()
            }
        } else if let articles = self.articles, !articles.isEmpty {
            view?.reloadData()
        } else {
            view?.configureNewLinkLabel(with: NewLinkLabelState.connectionError)
        }
    }
}
