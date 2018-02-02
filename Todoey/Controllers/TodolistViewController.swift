//
//  ViewController.swift
//  Todoey
//
//  Created by 최현빈 on 2018. 1. 18..
//  Copyright © 2018년 최현빈. All rights reserved.
//

import UIKit
import CoreData

class TodolistViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        

        
    }

    // Mark - TableView DataSource Methods - what the cells should display and how many rows we want in table view
    
    // How many of them to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // What to display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none

        
        return cell
    }
    
    // Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true) // check and fade away animation
    }
    
    // Mark - Add new items
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when the user clicks the Add Item button on our UIAlert
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new items"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Mark - Model Manupulation Methods
    
    func saveItems(){
        do{
            try context.save()
            
        } catch{
            print("Error saving context \(error)")
            
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[categoryPredicate,predicate!])
        }else{
            request.predicate = categoryPredicate
        }
        
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
        
    }
    
}

// MARK: - Search Bar methods

extension TodolistViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) // querying
        // [cd] -> to make case and diacritic insensitive
 
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)] //ascending -> alphabetical order
        loadItems(with: request, predicate: predicate)
        // hard to read when (request: request) so... -> (with : request)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0){
            loadItems()
            
            DispatchQueue.main.async { // bring it to the main thread
                searchBar.resignFirstResponder() // keyboard disappearing
            }
        }
    }
}

