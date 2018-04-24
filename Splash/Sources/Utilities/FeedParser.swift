//
//  Parser.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

enum RssTag: String {
    case item = "item"
    case title = "title"
    case description = "description"
    case pubDate = "pubDate"
    case imgUrl = "url"
    case image = "media:thumbnail"
}


class FeedParser: NSObject {
    fileprivate var parser = XMLParser()
    fileprivate var items = [ArticleItem]()
    fileprivate var completionHandler: (([ArticleItem]) -> Void)?
    
    fileprivate var currentElement = ""
    fileprivate var currentTitle = ""
    fileprivate var currentDescription = ""
    fileprivate var currentPubDate = ""
    fileprivate var currentImgUrl = ""
    
    
    
    func parseFeed(feedUrl: URL, completionHandler: (([ArticleItem]) -> Void)?) {
        self.completionHandler = completionHandler
        
        let request = URLRequest(url: feedUrl)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data
                else {
                    debugPrint(error ?? "Error is nil")
                    return
            }
            self?.parser = XMLParser(data: data)
            self?.parser.delegate = self
            self?.parser.parse()
        }
        task.resume()
    }
}

// MARK: - XMLParser Delegate
extension FeedParser: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        items = [ArticleItem]()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == RssTag.item.rawValue {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
        if currentElement == RssTag.imgUrl.rawValue {
            currentImgUrl = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case RssTag.title.rawValue:
            currentTitle += string
        case RssTag.description.rawValue:
            currentDescription += string
        case RssTag.pubDate.rawValue:
            currentPubDate += string
        case RssTag.imgUrl.rawValue:
            currentImgUrl += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == RssTag.item.rawValue {
            let title = trimmed(string: currentTitle)
            let description = trimmed(string: currentDescription)
            let pubDateString = trimmed(string: currentPubDate)
            let imgUrl = trimmed(string: currentImgUrl)
            print(imgUrl)
            
            items += [ArticleItem(title: title, description: description, pubDateString: pubDateString,imgUrl: imgUrl, expanded: false)]
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        guard let completionHandler = completionHandler else { return }
        completionHandler(items)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        debugPrint(parseError.localizedDescription)
    }
}

fileprivate extension FeedParser {
    func trimmed(string: String) -> String {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Presenter's methods
extension FeedParser {
    func returnItems() -> [ArticleItem] {
        return items
    }
}
