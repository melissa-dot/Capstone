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
    
    convenience init(date: Date, id: String, name: String, note: String, context: NSManagedObjectContext = AppDelegate.context) {
        self.init(context: context)
        self.date = date
        self.id = id
        self.name = name
        self.note = note
                
        try? context.save()
    }
    
    @NSManaged var customer: Customer
}
    
