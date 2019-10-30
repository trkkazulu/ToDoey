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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        print(dataFilePath)
        
       
        loadItems()
        
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
        
       saveItems()
        
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
  
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item please."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
                  
                  do {
                      
                      let data = try encoder.encode(itemArray)
                      
                      try data.write(to: dataFilePath!)
                      
                  } catch {
                      
                      print("Error encoding item array, \(error)")
                      
                  }
                  
                  self.tableView.reloadData()
 
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
        
        let decoder = PropertyListDecoder()
        
        do {
        itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decodeing item array, \(error)")
        }
    }
    }
    
}





