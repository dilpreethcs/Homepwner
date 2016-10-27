//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Dilpreet Singh on 27/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.date = item.dateCreated
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}