//
//  PersonInformationViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol PersonInformationViewProtocol: AnyObject { }

final class PersonInformationViewController: UIViewController {
    var presenter: PersonInformationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
        prepareSetup()
        view.backgroundColor = AppColors.bgColor
    }
    
    private func prepareSetup() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}
