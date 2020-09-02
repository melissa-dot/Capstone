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
    func saveNewProject(name: String, date: Date? = nil, note: String? = nil) {
        _ = Project(name: name, date: date, note: note)
        save()
    }
        
    func updateProject() {
        
    }
    
    func fetchAllProjects() -> [Project] {
        let moc = AppDelegate.context
        let projectFetch: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            project = try moc.fetch(projectFetch) as! [Project]
            
            self.datePicker.date = project.date ?? Date()
            self.notesTextView.text = project.note
            self.nameTextField.text = project.name
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func deleteProject() {
        
    }
    
    func save() {
        do {
            try AppDelegate.context.save()
        } catch {
            debugPrint("Failed to save project: \(error)")
        }
    }
}
