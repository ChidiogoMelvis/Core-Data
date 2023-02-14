//
//  Fruits+CoreDataProperties.swift
//  Core Data
//
//  Created by Mac on 14/02/2023.
//
//

import Foundation
import CoreData


extension Fruits {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fruits> {
        return NSFetchRequest<Fruits>(entityName: "Fruits")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var number: Int64

}

extension Fruits : Identifiable {

}
