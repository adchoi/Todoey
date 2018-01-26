//
//  ViewController.swift
//  Todoey
//
//  Created by 최현빈 on 2018. 1. 18..
//  Copyright © 2018년 최현빈. All rights reserved.
//

import UIKit

class TodolistViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard // using user default to save data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to display the recent change
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{ // if this works
            itemArray = items //then do this
        }
        
    }

    // Mark - TableView DataSource Methods - what the cells should display and how many rows we want in table view
    
    // How many of them to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // What to display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // checkmark after touching the cell
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none // touching cell again -> delete the checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // not touching cell again -> remain checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true) // check and fade away animation
    }
    // Mark - Add new items
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() // creating a global variable
        
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when the user clicks the Add Item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") // using user default
            self.tableView.reloadData() // reloading the data so that it can reflects the changes in the array
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new items"
            textField = alertTextfield // use it here
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

