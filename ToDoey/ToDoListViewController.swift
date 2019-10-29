//
//  ToDoListViewController.swift
//  ToDoey
//
//  Created by Jair-Rohm Wells on 10/17/19.
//  Copyright © 2019 Jair-Rohm Wells. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = ["Find Mike", "Buy Eggs", "Destroy all gods"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            
            itemArray = items
        }
    }
    
    //MARK: TableViewDataSource methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(indexPath.row)
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add new items
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //code to do what happens
            
            print("Success!")
            
            self.itemArray.append(textField.text!)
            
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







