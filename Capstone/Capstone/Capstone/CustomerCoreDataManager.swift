//
//  CustomerCoreDataManager.swift
//  Capstone
//
//  Created by Melissa Poulsen on 11/20/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import CoreData

struct CustomerCoreDataManager {
    static func saveNewCustomer(name: String, phone: String, email: String) {
        _ = Customer(email: email, name: name, phone: phone)
        save()
    }
    
    static func updateCustomer() {
}

    static func fetchAllCustomers() -> [Customer] {
        let moc = AppDelegate.context
        let customerFetch: NSFetchRequest<Customer> = NSFetchRequest<Customer> (entityName: "Customer")
        do {
            let customers = try moc.fetch(customerFetch)
            
            return customers
            
        } catch {
            fatalError("Failed to fetch customers: \(error)")
        }
        return []
    }

    static func deleteCustomer(_ customer: Customer) {
        AppDelegate.context.delete(customer)
        save()
    }

    static func save() {
        do {
            try AppDelegate.context.save()
        } catch {
            debugPrint("Failed to save customer: \(error)")
        }
    }
}

