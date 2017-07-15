//
//  First+CoreDataProperties.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 22.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import Foundation
import CoreData


extension First {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<First> {
        return NSFetchRequest<First>(entityName: "First")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var type: String?
    @NSManaged public var tag: String?
    @NSManaged public var priority: Int16
    @NSManaged public var toSecond: NSSet?

}

// MARK: Generated accessors for toSecond
extension First {

    @objc(addToSecondObject:)
    @NSManaged public func addToToSecond(_ value: Second)

    @objc(removeToSecondObject:)
    @NSManaged public func removeFromToSecond(_ value: Second)

    @objc(addToSecond:)
    @NSManaged public func addToToSecond(_ values: NSSet)

    @objc(removeToSecond:)
    @NSManaged public func removeFromToSecond(_ values: NSSet)

}
