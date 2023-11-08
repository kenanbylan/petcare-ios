//
//  RegisterViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func createAccountUserControl() -> Void
}

final class RegisterViewController: UIViewController {
    
    var presenter: RegisterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    @IBAction func ForgotPasswordButtonClicked(_ sender: Any) {
        presenter?.navigateToForgotPassword()
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func createAccountUserControl() {
        
    }
}
