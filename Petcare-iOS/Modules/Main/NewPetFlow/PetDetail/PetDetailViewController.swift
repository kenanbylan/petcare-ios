//
//  PetDetailViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import UIKit


protocol PetDetailViewProtocol: AnyObject {
    func setupUI()
}

class PetDetailViewController: BaseViewController {
    var presenter: PetDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.primaryColor
    }
}

extension PetDetailViewController: PetDetailViewProtocol {
    func setupUI() { }
    
}
