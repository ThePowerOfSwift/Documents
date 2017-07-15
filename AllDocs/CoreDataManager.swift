//
//  CoreDataManager.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 20.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
    
    
    static let instance = CoreDataManager()
    
    func entityForName(_ entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext)!
    }
    
    
    func FRC(_ entityName: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: UserDefaults.standard.string(forKey: "sortName") ?? "type", ascending: UserDefaults.standard.value(forKey: "accending") as? Bool ?? true )
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    
    func performFetch (_ frc: NSFetchedResultsController<NSFetchRequestResult>) {
        do {
            try frc.performFetch()
        }catch{
            print(error)
        }
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AllDocs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
