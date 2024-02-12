//
//  AppearanceViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import UIKit

protocol ApperanceViewProtocol: AnyObject { }


final class AppearanceViewController: BaseViewController {
    var presenter: ApperancePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTitle()
        view.backgroundColor = AppColors.bgColor
    }

    private func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }

}
