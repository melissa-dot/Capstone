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
    let projectCoreDataManager = ProjectCoreDataManager()
    var customer: Customer? 
    
    var didAddOrUpdateProject : (() -> ())?
    
    override func viewDidLoad() {
        
        if let project = project {
            self.datePicker.date = project.date ?? Date()
            self.notesTextView.text = project.note
            self.nameTextField.text = project.name
            self.phoneTextField.text = project.phone
            self.addressTextField.text = project.address
            self.emailTextField.text = project.email
        }
        
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.presentingViewController != nil {
            // Navigation controller is being presented modally
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
            self.navigationItem.leftBarButtonItem = cancelButton
        }
    }
    @IBAction func scheduledDateToggle(_ sender: UISwitch) {
        datePicker.isHidden = !sender.isOn
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty
            
        else {
            return
        }
        
        let date : Date? = datePicker.isHidden ? nil : datePicker.date
        
        if let project = project {
            ProjectCoreDataManager.updateProject()
            project.date = date
            project.note = notesTextView.text
            project.name = name
            project.phone = phoneTextField.text ?? ""
            project.address = addressTextField.text ?? ""
            project.email = emailTextField.text ?? ""
            

            ProjectCoreDataManager.save()
            navigationController?.popViewController(animated: true)
        } else {
            
            ProjectCoreDataManager.saveNewProject(name: name, date: date, note: notesTextView.text, phone: phoneTextField.text ?? "", address: addressTextField.text ?? "", email: emailTextField.text ?? "", customer: customer)
            dismiss(animated: true, completion: nil)
        }
        self.didAddOrUpdateProject?()

    }
    
    

    
}
