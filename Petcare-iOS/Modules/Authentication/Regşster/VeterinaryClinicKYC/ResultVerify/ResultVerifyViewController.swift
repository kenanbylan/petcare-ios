//
//  ResultVerifyViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol ResultVerifyViewProtocol: AnyObject {
    func forgotPasswordReset()
}

final class ResultVerifyViewController: UIViewController {
    var presenter: ResultVerifyPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.primaryColor
        
        title = "Result Verify"
    }
    

}
