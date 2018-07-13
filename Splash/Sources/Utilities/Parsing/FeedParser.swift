//
//  Parser.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

enum RssTag: String {
    case item
    case title
    case description
    case pubDate
    case channel
}

class FeedParser: NSObject {
    fileprivate var parser = XMLParser()
    fileprivate var items = [ArticleItem]()
    fileprivate var completionHandler: (([ArticleItem]) -> Void)?
    fileprivate var parserError: Error?

    fileprivate var currentElement = ""
    fileprivate var currentTitle = ""
    fileprivate var currentDescription = ""
    fileprivate var currentPubDate = ""
    fileprivate var channelTitle = ""
    fileprivate var currentURL = ""
    fileprivate var isChannelTitle = false

    func parseFeed(feedUrl: URL, errorHandler: @escaping ((Error?) -> Void), completionHandler: (([ArticleItem]) -> Void)?) {
        self.completionHandler = completionHandler

        let request = URLRequest(url: feedUrl)
        let task = URLSession.shared.dataTask(with: request) {  (data, response, error) in
            guard let data = data
                else {
                    debugPrint(error ?? "Error is nil")
                    errorHandler(error)
                    return
            }
            self.parser = XMLParser(data: data)
            self.parser.delegate = self
            self.parser.parse()
            errorHandler(self.parserError)
        }
        task.resume()
    }
}

// MARK: - XMLParser Delegate
extension FeedParser: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        items = [ArticleItem]()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName
        if currentElement == RssTag.item.rawValue {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
        
        if currentElement == RssTag.channel.rawValue {
            channelTitle = ""
            isChannelTitle = true
        }
        
        if !attributeDict.isEmpty {
            guard attributeDict["type"] == "image/jpeg" else { return }
            guard let url = attributeDict["url"] else { return }
            currentURL = url
        }
        
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case RssTag.title.rawValue:
            if isChannelTitle {
                channelTitle += string
                isChannelTitle = false
            } else {
                currentTitle += string
            }
        case RssTag.description.rawValue:
            currentDescription += string
        case RssTag.pubDate.rawValue:
            currentPubDate += string
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == RssTag.item.rawValue {
            let title = trimmed(string: currentTitle)
            let description = trimmed(string: currentDescription)
            let pubDateString = trimmed(string: currentPubDate)
            let url = currentURL
            let rfc2822DateFormatter = RFC2822DateFormatter()
            let date = rfc2822DateFormatter.date(from: pubDateString)

            items += [ArticleItem(title: title, description: description, url: url, pubDate: date ?? Date(), expanded: false)]
        }
        if elementName == RssTag.channel.rawValue  {
            self.channelTitle = trimmed(string: channelTitle)
            print("We have a name: \(channelTitle)")
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        guard let completionHandler = completionHandler else { return }
        currentURL = ""
        completionHandler(items)
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        self.parserError = parseError
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
    func returnChannelName() -> String {
        return channelTitle
    }
}
