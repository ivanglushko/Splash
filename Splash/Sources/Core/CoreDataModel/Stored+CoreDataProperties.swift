//
//  Stored+CoreDataProperties.swift
//  Splash
//
//  Created by Ivan Glushko on 08.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//
//

import Foundation
import CoreData


extension Stored {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stored> {
        return NSFetchRequest<Stored>(entityName: "Stored")
    }

    @NSManaged public var isFirstTimeLaunched: Bool
    @NSManaged public var item: NSObject?
    @NSManaged public var note: NSObject?
    @NSManaged public var urls: String?
}
