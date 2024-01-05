//
//  UITextField + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 4.01.2024.
//

import UIKit


extension UITextField {
    func setInputViewDatePicker(targer: Any, selector: Selector) {
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: UIScreen.screenHeight / 3))
        datePicker.datePickerMode = .date
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        
        
        self.inputView = datePicker
        
        //CreateToolbar
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        
        toolbar.setItems([cancel,flexible,barButton], animated: true)
        self.inputAccessoryView = toolbar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }

    
}

