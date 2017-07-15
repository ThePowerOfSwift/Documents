//
//  First+CoreDataClass.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 22.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import Foundation
import CoreData


public class First: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForName("First"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
}
