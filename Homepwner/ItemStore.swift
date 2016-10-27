//
//  ItemStore.swift
//  Homepwner
//
//  Created by Dilpreet Singh on 21/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }

    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func movedItemAtIndex(fromIndexPath: Int, toIndexPath: Int) {
        if fromIndexPath == toIndexPath {
            return
        }

        let movedItem = allItems[fromIndexPath]
        
        if toIndexPath != (allItems.count - 1) {
            allItems.removeAtIndex(fromIndexPath)
            allItems.insert(movedItem, atIndex: toIndexPath)
        }
    }
}