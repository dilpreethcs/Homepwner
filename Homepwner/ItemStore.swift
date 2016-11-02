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

    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func movedItemAtIndex(_ fromIndexPath: Int, toIndexPath: Int) {
        if fromIndexPath == toIndexPath {
            return
        }

        let movedItem = allItems[fromIndexPath]
        
        if toIndexPath != (allItems.count - 1) {
            allItems.remove(at: fromIndexPath)
            allItems.insert(movedItem, at: toIndexPath)
        }
    }
}
