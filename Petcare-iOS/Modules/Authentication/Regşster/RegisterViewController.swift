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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func createAccountUserControl() {
        
    }
}
