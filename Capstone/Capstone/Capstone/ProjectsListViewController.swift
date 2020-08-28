//
//  ViewController.swift
//  Capstone
//
//  Created by Melissa Poulsen on 7/29/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import UIKit
import CoreData

class ProjectsListViewController: UITableViewController {

    var projectList = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let moc = AppDelegate.context
        let projectFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Project")
             
            do {
                projectList = try moc.fetch(projectFetch) as! [Project]
                
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
        self.tableView.reloadData()
    }
    
    
}
