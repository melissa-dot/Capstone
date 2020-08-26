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
    
    override func viewDidLoad() {
        if let project = project, let customer = customer {
            self.nameTextField.text = project.name
            self.phoneTextField.text = customer.phone
            
            // add all values for project AND customer
            
        }
        super.viewDidLoad()

    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty
            
            // add all values for project AND? customer
        
        else {
            return
        }
        if let project = project,
            let customer = customer {
            project.name = name
            
            //add all values for project AND customer
            
            try? AppDelegate.context.save()
        } else {
            //init all properties
            
        //    _ = Project(date: , id: <#T##String#>, name: name, note: <#T##String#>)
            
         //   _ = Customer( )
            
        }
        
    //    saveButton.isEnabled = !text.isEmpty
    }
    

    
}
