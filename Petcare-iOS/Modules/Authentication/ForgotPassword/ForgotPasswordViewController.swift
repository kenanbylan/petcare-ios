//
//  ForgotPasswordViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import UIKit

protocol ForgotPasswordViewProtocol: AnyObject {
    func createAccountUserControl()
}


final class ForgotPasswordViewController: UIViewController {
    var presenter: ForgotPasswordPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    @IBAction func BacktoLoginClicked(_ sender: Any) {
        presenter?.backToLogin()
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    func createAccountUserControl() {
        
    }
    
    
}
