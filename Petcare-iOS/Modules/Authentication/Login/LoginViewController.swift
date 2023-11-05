//
//  LoginViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func loginUserControl()
}

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    @IBOutlet weak var loginButtonClicked: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
    }
}


extension LoginViewController: LoginViewControllerProtocol {
    func loginUserControl() {
        
    }
}
