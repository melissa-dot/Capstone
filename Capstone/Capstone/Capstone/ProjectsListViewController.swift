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

    var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
        
    }
    
}
