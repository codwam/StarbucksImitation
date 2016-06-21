//
//  DateTextField.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/21.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class DateTextField: UITextField {
    
    private var datePicker: UIDatePicker!
    private lazy var dateFormatter = NSDateFormatter()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.constructView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.constructView()
    }
    
    func constructView() {
        // Date picker
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = .Date
        self.datePicker.maximumDate = NSDate()
        self.datePicker.addTarget(self, action: #selector(DateTextField.dateChanged(_:)), forControlEvents: .ValueChanged)
        // Date formatter
        self.dateFormatter.dateStyle = .MediumStyle
        
        self.inputView = self.datePicker
    }
    
    @objc private func dateChanged(sender: UIDatePicker) {
        self.text = self.dateFormatter.stringFromDate(sender.date)
    }

}
