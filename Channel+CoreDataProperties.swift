//
//  Channel+CoreDataProperties.swift
//  Splash
//
//  Created by Ivan Glushko on 14/05/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//
//

import Foundation
import CoreData


extension Channel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Channel> {
        return NSFetchRequest<Channel>(entityName: "Channel")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var article: Article?

}
