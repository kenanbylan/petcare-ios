//
//  VeterinaryHomeViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol VeterinaryHomeViewProtocol: AnyObject {
    
}

final class VeterinaryHomeViewController: UIViewController {
    var presenter: VeterinaryHomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        prepareTitleLabel()
    }
    
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Veterinary Home", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonTapped))
        addButton.tintColor = AppColors.primaryColor
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        presenter?.navigateToDateList()
    }
    
}
