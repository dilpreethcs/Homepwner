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
    
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            sender.setTitle("Edit", forState: .Normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", forState: .Normal)
            setEditing(true, animated: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (itemStore.allItems.count + 1)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row != itemStore.allItems.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
            
            let item = itemStore.allItems[indexPath.row]
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            
            if item.valueInDollars < 50 {
                cell.valueLabel.textColor = UIColor.greenColor()
            } else {
                cell.valueLabel.textColor = UIColor.redColor()
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("StaticCell", forIndexPath: indexPath)
            return cell
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == itemStore.allItems.count {
            return false
        }
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item??"
            
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .Destructive, handler: { (action) in
                self.itemStore.removeItem(item)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            alertController.addAction(deleteAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        if toIndexPath.row != itemStore.allItems.count {
            itemStore.movedItemAtIndex(fromIndexPath.row, toIndexPath: toIndexPath.row)
        }
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if indexPath.row == itemStore.allItems.count {
            return false
        }
        
        return true
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        if proposedDestinationIndexPath.row == itemStore.allItems.count {
            let indexPath = NSIndexPath(forRow: itemStore.allItems.count - 1, inSection: 0)
            return indexPath
        }
        return proposedDestinationIndexPath
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailVC = segue.destinationViewController as! DetailViewController
                detailVC.item = item
            }
        }
    }
    
}
