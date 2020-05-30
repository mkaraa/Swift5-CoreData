//
//  Student+CoreDataProperties.swift
//  CoreData2
//
//  Created by Syed Ali on 5/4/20.
//  Copyright © 2020 CTIS. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var midterm: Double
    @NSManaged public var final: Double

}
