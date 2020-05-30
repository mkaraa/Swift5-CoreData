//
//  Student+CoreDataClass.swift
//  CoreData2
//
//  Created by Syed Ali on 5/4/20.
//  Copyright © 2020 CTIS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {
    
    // Static method (class keyword)
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, name: String, surname: String, midterm: NSNumber, final: NSNumber) -> Student {
        let studentObject = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        studentObject.name = name
        studentObject.surname = surname
        studentObject.midterm = Double(truncating: midterm)
        studentObject.final = Double(truncating: final)
        
        return studentObject
    }

}
