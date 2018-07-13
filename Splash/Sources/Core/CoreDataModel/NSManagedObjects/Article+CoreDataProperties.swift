//
//  Article+CoreDataProperties.swift
//  Splash
//
//  Created by Ivan Glushko on 20.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//
//

import Foundation
import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var descriptionString: String
    @NSManaged public var expanded: Bool
    @NSManaged public var id: String
    @NSManaged public var pubDate: Date
    @NSManaged public var title: String
    @NSManaged public var imageUrl: String
    @NSManaged public var picture: NSData?
    @NSManaged public var channel: Channel?

}
