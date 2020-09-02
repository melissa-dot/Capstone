//
//  NewProjectTableViewController.swift
//  Capstone
//
//  Created by Melissa Poulsen on 8/18/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import UIKit

class NewProjectTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var project: Project?
    var customer: Customer?
    let projectCoreDataManager = ProjectCoreDataManager()
    
    override func viewDidLoad() {
        if let project = project, let customer = customer {
            self.datePicker.date = project.date ?? Date()
            self.notesTextView.text = project.note
            self.nameTextField.text = project.name
            
            self.addressTextField.text = customer.address
            self.emailTextField.text = customer.email
            self.nameTextField.text = customer.name
            self.phoneTextField.text = customer.phone
        }
        super.viewDidLoad()

    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let address = addressTextField.text, !address.isEmpty
            
        else {
            return
        }
        
        if let project = project {
            projectCoreDataManager.updateProject()
            project.date = datePicker.date
            project.note = notesTextView.text
            project.name = name
            
            customer.address = address
            customer.email = email
            customer.name = name
            customer.phone = phoneNumber
        } else {
            saveNewProject(name: name)
        }

    }
    
    func saveNewProject(name: String) {
        projectCoreDataManager.saveNewProject(name: name, date: datePicker.date, note: notesTextView.text)
        
       // _ = Customer(id: UUID().uuidString, email: email, name: name, phone: phoneNumber)
        
    }
    

    
}
