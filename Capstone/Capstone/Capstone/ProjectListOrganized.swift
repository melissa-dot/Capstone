//
//  ProjectListOrganized.swift
//  Capstone
//
//  Created by Melissa Poulsen on 9/11/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    static let identifier = "Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

struct Person {
    var firstName: String
    var date: Date?
}

class ViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
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
    
    var people: [Person] = []
    var sortedByAlphabet: [String: [Person]] = [:]
    var sortedByDate: [Date: [Person]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        people = [
            Person(firstName: "Allen", date: date(fromString: "2020-01-10")),
            Person(firstName: "Lindsey", date: date(fromString: "2020-01-10")),
            Person(firstName: "Zeke", date: date(fromString: "2020-06-10")),
            Person(firstName: "Amy", date: date(fromString: "2020-10-10")),
            Person(firstName: "Steve", date: date(fromString: "2020-12-10")),
        ]
        
        
        
        sortByDate()
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    func sortByAlphabet() {
        for person in people {
            if let firstLetter = person.firstName.first?.uppercased() {
                sortedByAlphabet[firstLetter, default: []].append(person)
            }
        }
    }
    
    func sortByDate() {
        for person in people {
            if let date = person.date {
                sortedByDate[date, default: []].append(person)
            }
        }
    }
    
    func date(fromString: String) -> Date? {
        return dateFormatter.date(from: fromString)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func sortedSections() -> [Date] {
        sortedByDate.keys.sorted()
    }
    
    func people(forSection section: Int) -> [Person] {
        let key = self.key(forSection: section)
        return sortedByDate[key, default: []]
    }
    
    func key(forSection section: Int) -> Date {
        sortedSections()[section]
    }
    
    func person(forIndexPath indexPath: IndexPath) -> Person {
        let key = sortedSections()[indexPath.section]
        return sortedByDate[key, default: []][indexPath.row]
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sortedSections().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people(forSection: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath)
        cell.backgroundColor = .magenta
        
        let person = self.person(forIndexPath: indexPath)
        cell.textLabel?.text = person.firstName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = self.key(forSection: section)
        return prettyDateFormatter.string(from: date)
    }
}

