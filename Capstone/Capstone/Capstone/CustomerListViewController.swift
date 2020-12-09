//
//  CustomerListViewController.swift
//  Capstone
//
//  Created by Melissa Poulsen on 11/12/20.
//  Copyright © 2020 Melissa Poulsen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CustomerListViewController: UITableViewController {
    var customers = [Customer]()
    
    @objc func alert() {
        
        let alert = UIAlertController(title: "Add New Customer", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Name" })
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Phone Number" })
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Email" })

        let submitAction = UIAlertAction(title: "Save", style: .default, handler: { (action) in
            guard let textFieldArray = alert.textFields,
                  let nameText = textFieldArray[0].text,
                  let phoneText = textFieldArray[1].text,
                  let emailText = textFieldArray[2].text else { return }
            let customer = Customer(email: emailText, name: nameText, phone: phoneText)
            self.customers.append(customer)
            try? AppDelegate.context.save()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(alert))
        
        title = "Customers"
        
        reloadCustomers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell", for: indexPath)
        
        let customer = self.customers[indexPath.row]
        cell.textLabel?.text = customer.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = self.customers[indexPath.row]
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProjectsListViewController") as? ProjectsListViewController {
            viewController.customer = customer
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func deleteCustomer(forIndexPath indexPath: IndexPath) {
        customers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let customer = self.customers[indexPath.row]
            
            CustomerCoreDataManager.deleteCustomer(customer)
            deleteCustomer(forIndexPath: indexPath)
            
        }
    }
    
    func reloadCustomers() {
        customers = CustomerCoreDataManager.fetchAllCustomers()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}



