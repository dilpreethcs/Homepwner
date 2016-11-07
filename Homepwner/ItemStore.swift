//
//  ItemStore.swift
//  Homepwner
//
//  Created by Dilpreet Singh on 21/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class ItemStore {
    
    private lazy var allItems : [Item] = {
        return [Item]()
    }()
    
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
        if fromIndexPath == toIndexPath || toIndexPath != (allItems.count - 1) {
            return
        }
        
        let movedItem = allItems[fromIndexPath]
        allItems.remove(at: fromIndexPath)
        allItems.insert(movedItem, at: toIndexPath)
    }
    
    func index(_ item: Item) -> Int? {
        return allItems.index(of: item) ?? nil
    }
    
    func allItemsCount() -> Int {
        return allItems.count
    }
    
    func item(atIndex: Int) -> Item {
        return allItems[atIndex] 
    }
    
}
