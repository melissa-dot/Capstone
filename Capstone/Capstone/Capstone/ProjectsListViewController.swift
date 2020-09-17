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
    var sortedByDate: [Date: [Project]] = [:]
    var sortedByAlphabet: [String: [Project]] = [:]
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    lazy var prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadProjects()
    }
    
    func sortByAlphabet() {
           for project in projects {
               if let firstLetter = project.name.first?.uppercased() {
                   sortedByAlphabet[firstLetter, default: []].append(project)
               }
           }
       }
    
    /// sorts projects by date, if project has one, per section.
    func sortByDate() {
        var tempProjects = projects
        let noDateProjects = projects.filter({ $0.date == nil })
        print(noDateProjects)
        sortedByDate[Date.distantPast] = noDateProjects
        tempProjects.removeAll(where: { $0.date == nil })
        while tempProjects.count > 0 {
            guard let firstProject = tempProjects.first else { return }
            let projectDate = firstProject.date!
            let projectsSameDate = tempProjects.filter({ Calendar.current.isDate($0.date!, inSameDayAs: projectDate) })
            sortedByDate[projectDate] = projectsSameDate
            tempProjects.removeAll(where: { Calendar.current.isDate($0.date!, inSameDayAs: projectDate) })
        }

    }
       
       func date(fromString: String) -> Date? {
           return dateFormatter.date(from: fromString)
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addButtonTapped",
        let navController = segue.destination as? UINavigationController,
        let viewController = navController.topViewController as? NewProjectTableViewController {
            viewController.didAddOrUpdateProject = {
                self.reloadProjects()
                
            }
        }
        
    }
    func reloadProjects() {
        projects = ProjectCoreDataManager.fetchAllProjects()
             sortByDate()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
             
    }
}



extension ProjectsListViewController {
    
    func sortedSections() -> [Date] {
        sortedByDate.keys.sorted()
    }
    
    func projects(forSection section: Int) -> [Project] {
        let key = self.key(forSection: section)
        return sortedByDate[key, default: []]
    }
    
    func key(forSection section: Int) -> Date {
        sortedSections()[section]
    }
    
    func project(forIndexPath indexPath: IndexPath) -> Project {
        let key = sortedSections()[indexPath.section]
        return sortedByDate[key, default: []][indexPath.row]
    }
    func deleteProject(forIndexPath indexPath: IndexPath) {
        let key = sortedSections()[indexPath.section]
        guard var projects = sortedByDate[key] else {
            return
        }
        projects.remove(at: indexPath.row)
        sortedByDate[key] = projects
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedSections().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projects(forSection: section).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowTemplate", for: indexPath)
        cell.backgroundColor = .magenta
        
        let project = self.project(forIndexPath: indexPath)
        cell.textLabel?.text = project.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = self.project(forIndexPath: indexPath)
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewProjectTableViewController") as? NewProjectTableViewController {
            viewController.project = project
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = self.key(forSection: section)
        if date == Date.distantPast {
            return "No appointment"
        }
        return prettyDateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let project = self.project(forIndexPath: indexPath)
            

            ProjectCoreDataManager.deleteProject(project)
            projects.remove(at: indexPath.row)
            deleteProject(forIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    
    
}


