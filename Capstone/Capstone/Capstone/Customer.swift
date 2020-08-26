//
//  Customer.swift
//  Capstone
//
//  Created by Melissa Poulsen on 8/26/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import CoreData

class Customer: NSManagedObject {
    @NSManaged var address: String?
    @NSManaged var email: String
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var phone: String
    
    @NSManaged var projects: [Project]
    
    // Copy "self.name" from project 
}

