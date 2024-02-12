//
//  ManageNotificationViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol ManageNotificationViewProtocol: AnyObject { }


final class ManageNotificationViewController: UIViewController {
    var presenter: ManageNotificationPresenterProtocol!

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
