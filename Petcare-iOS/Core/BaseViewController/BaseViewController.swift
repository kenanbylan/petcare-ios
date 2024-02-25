//
//  BaseViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import UIKit


class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        networkControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkControl()
    }
    
    
    private func networkControl() {
        if NetworkMonitor.shared.isConnected {
            print("You're connected")
            
            AlertView.shared.showAlert(title: "Title", message: "Message", buttonType: .multiButton, onPrimaryTapped: {
                print("Primary button tapped")
            }, onSecondaryTapped: {
                print("Secondary button tapped")
            })
        } else {
            
        }
    }
    
    fileprivate func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("Back", color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
