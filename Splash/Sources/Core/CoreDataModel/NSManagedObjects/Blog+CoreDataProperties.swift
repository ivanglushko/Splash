//
//  Blog+CoreDataProperties.swift
//  Splash
//
//  Created by Ivan Glushko on 31/05/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//
//

import Foundation
import CoreData


extension Blog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Blog> {
        return NSFetchRequest<Blog>(entityName: "Blog")
    }

    @NSManaged public var title: String
    @NSManaged public var fill: String?

}
