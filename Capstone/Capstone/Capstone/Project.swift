//
//  ProjectObject.swift
//  Capstone
//
//  Created by Melissa Poulsen on 8/24/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {
    
    @NSManaged var date: Date?
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var note: String
    @NSManaged var phone: String
    @NSManaged var address: String
    @NSManaged var email: String
    
    convenience init(name: String, date: Date? = nil, note: String? = nil, phone: String, address: String, email: String, customer: Customer? = nil, context: NSManagedObjectContext = AppDelegate.context) {
        self.init(context: context)
        self.name = name
        self.phone = phone
        self.address = address
        self.email = email
        if let date = date {
            self.date = date
        } 
        self.id = UUID().uuidString
        if let note = note {
            self.note = note
        }
        if let customer = customer {
            self.customer = customer
        }
        do {
           try context.save()
        }
        catch {
            print(error)
        }
        print(self.date)
        print(Date.distantPast)
    }
    
    @NSManaged var customer: Customer
}
    
