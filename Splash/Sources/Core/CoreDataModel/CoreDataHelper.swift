//
//  CoreDataHelper.swift
//  Splash
//
//  Created by Ivan Glushko on 08.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataHelper {
    
    static var shared = CoreDataHelper()
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Stored")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var articleEntity: NSEntityDescription?
    var isCurrentPredicate = NSPredicate(format: "isCurrent == true")
    
    init() {
        self.articleEntity  = NSEntityDescription.entity(forEntityName: "Article", in: context)
    }
    
    
     func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error
                print(nserror)
                fatalError("\(nserror)")
            }
        }
    }
    
    func fetch(entity: String, predicate: NSPredicate? = nil) -> [Any] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if let predicate = predicate {
            request.predicate = predicate
        }
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            fatalError("\(error)")
        }
    }
    
    func delete(object: NSManagedObject) {
        context.delete(object)
    }
    
    func deleteAll(fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        }catch let err {
            print("Error due deletion: \(err)")
        }
        save()
    }
}
