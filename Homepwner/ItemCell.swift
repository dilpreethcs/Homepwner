//
//  ItemCell.swift
//  Homepwner
//
//  Created by Dilpreet Singh on 24/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configureCell(_ item: Item, indexPath: IndexPath) {
        self.nameLabel.text = item.name
        self.serialNumberLabel.text = item.serialNumber
        self.valueLabel.text = "$\(item.valueInDollars)"
    }
}
