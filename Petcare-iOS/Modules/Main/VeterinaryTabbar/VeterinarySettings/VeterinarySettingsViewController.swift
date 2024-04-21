//
//  VeterinarySettingsViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol VeterinarySettingsViewProtocol: AnyObject {
    
}

final class VeterinarySettingsViewController: UIViewController {
    var presenter: VeterinarySettingsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        
        prepareTitleLabel()
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Veterinary Settings", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}
