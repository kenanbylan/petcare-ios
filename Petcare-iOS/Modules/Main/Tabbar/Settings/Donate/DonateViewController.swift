//
//  DonateViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol DonateViewProtocol: AnyObject { }

final class DonateViewController: UIViewController {
    var presenter: DonatePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
    }
}
