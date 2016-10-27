//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Dilpreet Singh on 24/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    var item: Item!
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
       let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.name
        serialNumberTextField.text = item.serialNumber
        valueTextField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateCreatedLabel.text = dateFormatter.stringFromDate(item.dateCreated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialNumberTextField.text
        
        if let valueText = valueTextField.text, value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "DatePicker" {
            let datePickerVC = segue.destinationViewController as! DatePickerViewController
            datePickerVC.item = item
        }
        // Pass the selected object to the new view controller.
    }

}
