//
//  Channel+CoreDataProperties.swift
//  Splash
//
//  Created by Ivan Glushko on 20.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//
//

import Foundation
import CoreData

extension Channel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Channel> {
        return NSFetchRequest<Channel>(entityName: "Channel")
    }

    @NSManaged public var id: String
    @NSManaged public var isCurrent: Bool
    @NSManaged public var name: String?
    @NSManaged public var url: String
    @NSManaged public var articles: NSSet?

}

// MARK: Generated accessors for article
extension Channel {

    @objc(addArticleObject:)
    @NSManaged public func addToArticle(_ value: Article)

    @objc(removeArticleObject:)
    @NSManaged public func removeFromArticle(_ value: Article)

    @objc(addArticle:)
    @NSManaged public func addToArticle(_ values: NSSet)

    @objc(removeArticle:)
    @NSManaged public func removeFromArticle(_ values: NSSet)

}
