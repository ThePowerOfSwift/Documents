//
//  Second+CoreDataClass.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 22.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import Foundation
import CoreData


public class Second: NSManagedObject {

    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForName("Second"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
}
