//
//  PetInfoViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit


protocol PetInfoViewProtocol: AnyObject {
    func prepareUI()
}

final class PetInfoViewController: UIViewController {
    var presenter: PetInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
    }
}

extension PetInfoViewController: PetInfoViewProtocol {
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
    }
    
    private func prepareTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.configurationTitleLabel(withText: "Great!", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension PetInfoViewController: ViewCoding {
    func setupView() { }
    
    func setupHierarchy() { }
    
    func setupConstraints() { }
}

