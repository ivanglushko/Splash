//
//  CoreDataHelper.swift
//  Splash
//
//  Created by Ivan Glushko on 08.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Stored")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    static let articleEntity = NSEntityDescription.entity(forEntityName: "Article", in: context)
    

    
    static func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("\(nserror)")
            }
        }
    }
    
    static func fetch(entity: String) -> [Any] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            fatalError("\(error)")
        }
    }
    
    static func delete(object: NSManagedObject) {
        context.delete(object)
    }
}
