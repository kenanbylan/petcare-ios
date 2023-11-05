//
//  SplashViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    func noInternetConnection()
    func prepareUI()
}

class SplashViewController: UIViewController {
    var presenter: SplashPresenter! //will be changes SplashPresenterProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        //presenter.navigateToOnboarding(navigationController: self.navigationController)
     }
    
}

extension SplashViewController: SplashViewProtocol {
    
    func noInternetConnection() { }
    
    func prepareUI() {
        view.backgroundColor = .yellow
    }
}

