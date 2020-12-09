//
//  ProjectCoreDatatManager.swift
//  Capstone
//
//  Created by Melissa Poulsen on 9/1/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import CoreData

struct ProjectCoreDataManager {
    static func saveNewProject(name: String, date: Date? = nil, note: String? = nil, phone: String, address: String, email: String, customer: Customer?) {
        let project = Project(name: name, date: date, note: note, phone: phone, address: address, email: email)
        if let customer = customer {
            project.customer = customer
        }
        save()
    }
        
   static func updateProject() {
        
    }
    
    static func fetchAllProjects() -> [Project] {
        let moc = AppDelegate.context
        let projectFetch: NSFetchRequest<Project> = NSFetchRequest<Project>(entityName: "Project")
        do {
           let projects = try moc.fetch(projectFetch) 
            
            return projects

        } catch {
            fatalError("Failed to fetch projects: \(error)")
        }
        return []
    }
    
    static func deleteProject(_ project: Project) {
        AppDelegate.context.delete(project)
        save()
    
    }
    
   static func save() {
        do {
            try AppDelegate.context.save()
        } catch {
            debugPrint("Failed to save project: \(error)")
        }
    }
}
