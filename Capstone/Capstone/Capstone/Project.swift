//
//  ProjectObject.swift
//  Capstone
//
//  Created by Melissa Poulsen on 8/24/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import CoreData

class Project: NSManagedObject {
    @NSManaged var date: Date?
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var note: String
    
    @NSManaged var customer: Customer
    
    
}

class Customer: NSManagedObject {
    @NSManaged var address: String?
    @NSManaged var email: String
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var phone: String
    
    @NSManaged var projects: [Project]
    
}
