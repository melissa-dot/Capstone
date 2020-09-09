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
   static func saveNewProject(name: String, date: Date? = nil, note: String? = nil) {
        _ = Project(name: name, date: date, note: note)
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
            fatalError("Failed to fetch employees: \(error)")
        }
        return []
    }
    
   static func deleteProject() {
    let moc = AppDelegate.context.deletedObjects
    }
    
   static func save() {
        do {
            try AppDelegate.context.save()
        } catch {
            debugPrint("Failed to save project: \(error)")
        }
    }
}
