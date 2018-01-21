//
//  ViewController.swift
//  Todoey
//
//  Created by 최현빈 on 2018. 1. 18..
//  Copyright © 2018년 최현빈. All rights reserved.
//

import UIKit

class TodolistViewController: UITableViewController {
    
   let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
  


}

