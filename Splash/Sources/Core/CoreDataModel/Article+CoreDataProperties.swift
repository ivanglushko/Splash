//
//  Article+CoreDataProperties.swift
//  Splash
//
//  Created by Ivan Glushko on 17.05.18.
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
    @NSManaged public var imgUrl: String
    @NSManaged public var pubDateString: String
    @NSManaged public var title: String
    @NSManaged public var id: String
    @NSManaged public var isFavourite: Bool
    @NSManaged public var url: Channel?

}
