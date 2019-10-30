//
//  ToDoListViewController.swift
//  ToDoey
//
//  Created by Jair-Rohm Wells on 10/17/19.
//  Copyright © 2019 Jair-Rohm Wells. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.title = "Create, create, create"
        itemArray.append(newItem2)
        
        
        let newItem3 = Item()
        newItem3.title = "Destroy all gods"
        itemArray.append(newItem3)
        
        
        let newItem4 = Item()
        newItem4.title = "Clean up dad"
        itemArray.append(newItem4)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            
            itemArray = items
        }
        
    }
    
    //MARK: TableViewDataSource methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Tenary operator ==> value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // This is the simplest form of a toggle. Use this.
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
            }
    
    //MARK: Add new items
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //code to do what happens
            
            print("Success!")
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
            
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item please."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
}





