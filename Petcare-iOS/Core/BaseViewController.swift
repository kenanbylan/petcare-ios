//
//  BaseViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import UIKit


class BaseViewController: UIViewController {
    
    // Alt sınıfların bu metodu override edebilmesi için open olarak işaretlendi
    open override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    fileprivate func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("Back", color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
}
