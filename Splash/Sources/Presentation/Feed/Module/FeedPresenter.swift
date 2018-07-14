//
//  FeedPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import SystemConfiguration

class FeedPresenter {
    weak var view: FeedViewInput?
    private let feedParser = FeedParser()
    private var items: [ArticleItem] = []
    
    private lazy var channel: Channel? = {
        fetchChannel()
    }()
    
    private var articles: [Article]? {
        let articles = channel?.articles?.allObjects as? [Article]
        let sortedArticles = articles?.sorted { $0.pubDate < $1.pubDate }
        return sortedArticles
    }
    
    func fetchChannel() -> Channel? {
        let predicate = CoreDataHelper.shared.isCurrentPredicate
        guard let channels =  CoreDataHelper.shared.fetch(entity: "Channel", predicate: predicate) as? [Channel]
            else { return nil }
        guard let channel = channels.first else { return nil }
        return channel
    }
    
    func startParsingURLs() {
        if let urlString = channel?.url, let url = URL(string: urlString) {
            DispatchQueue.main.async { self.parseURL(url: url) }
        }
    }
    
    func parseURL(url: URL) {
        feedParser.parseFeed(feedUrl: url, errorHandler: { [weak self] (error) in
            if let error = error { self?.didFailureParsing(with: error) }
            }, completionHandler: { [weak self] (items) in
                DispatchQueue.main.async {
                    self?.didParseURL(with: items)
                }
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
            article.imageUrl = item.url
            downloadImage(url: item.url, article: article)
            article.channel = channel
        }
        CoreDataHelper.shared.save()
    }
    
    func downloadImage(url: String, article: Article) {
        let imageDownloader = ImageDownloader()
        imageDownloader.downloadImage(url: url) { (data) in
            DispatchQueue.main.async {
                article.picture = data
            }
        }
    }
    
    func didFailureParsing(with: Error) {
        DispatchQueue.main.async {
            self.items = []
            self.view?.reloadData()
            self.view?.configureNewLinkLabel(with: State.parsingError)
        }
    }
    
    func checkConnection() {
        let connectionChecker = ConnectionChecker()
        if connectionChecker.isReacheable {
            if channel != nil {
                view?.configureNewLinkLabel(with: State.loading)
                startParsingURLs()
            } else {
                items = []
                view?.reloadData()
                view?.showHint()
            }
        } else if let articles = articles, !articles.isEmpty {
            view?.reloadData()
        } else {
            view?.reloadData()
            view?.configureNewLinkLabel(with: State.connectionError)
        }
    }
}

//MARK: FeedViewOutput
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
        channel = fetchChannel()
        checkConnection()
    }
    
    // MARK: UITableViewDataSource
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


