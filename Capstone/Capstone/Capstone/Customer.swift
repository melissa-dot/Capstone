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
    
    convenience init(email: String, name: String, phone: String,context: NSManagedObjectContext = AppDelegate.context)
    {
        self.init(context: context)
        self.address = address
        self.email = email
        self.id = UUID().uuidString
        self.name = name
        self.phone = phone
    }
    
}

