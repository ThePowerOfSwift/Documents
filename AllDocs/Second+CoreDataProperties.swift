//
//  Second+CoreDataProperties.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 22.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import Foundation
import CoreData


extension Second {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Second> {
        return NSFetchRequest<Second>(entityName: "Second")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var type: String?
    @NSManaged public var tag: String?
    @NSManaged public var priority: Int16
    @NSManaged public var toFirst: First?

}
