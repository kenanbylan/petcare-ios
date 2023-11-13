//
//  LoginViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func loginUserControl()
}

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.primaryColor
        presenter?.load()
    }
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        print("Login button clicked")
        presenter?.navigateMain()
        ///MARK: if user data control is true Tabbar is wrong AlertView
    }
    
    @IBAction func SignUpButtonClicked(_ sender: Any) {
        presenter?.navigateSignUp()
    }
    
}


extension LoginViewController: LoginViewProtocol {
    func loginUserControl() {
        
    }
}
