//
//  ItemsTableViewController.swift
//  Homepwner
//
//  Created by Dilpreet Singh on 21/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: AnyObject) {
        if isEditing {
            sender.setTitle("Edit", for: UIControlState())
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: UIControlState())
            setEditing(true, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (itemStore.allItems.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row != itemStore.allItems.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            
            let item = itemStore.allItems[(indexPath as NSIndexPath).row]
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            
            if item.valueInDollars < 50 {
                cell.valueLabel.textColor = UIColor.green
            } else {
                cell.valueLabel.textColor = UIColor.red
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCell", for: indexPath)
            return cell
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if (indexPath as NSIndexPath).row == itemStore.allItems.count {
            return false
        }
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let item = itemStore.allItems[(indexPath as NSIndexPath).row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item??"
            
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) in
                self.itemStore.removeItem(item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        if (toIndexPath as NSIndexPath).row != itemStore.allItems.count {
            itemStore.movedItemAtIndex((fromIndexPath as NSIndexPath).row, toIndexPath: (toIndexPath as NSIndexPath).row)
        }
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if (indexPath as NSIndexPath).row == itemStore.allItems.count {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if (proposedDestinationIndexPath as NSIndexPath).row == itemStore.allItems.count {
            let indexPath = IndexPath(row: itemStore.allItems.count - 1, section: 0)
            return indexPath
        }
        return proposedDestinationIndexPath
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            if let row = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                let item = itemStore.allItems[row]
                let detailVC = segue.destination as! DetailViewController
                detailVC.item = item
            }
        }
    }
    
}
