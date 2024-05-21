//
//  SplashViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashViewController: BaseViewController {
    var presenter: SplashPresenterProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.presenter?.viewDidLoad()
        })
    }
}

extension SplashViewController: SplashViewProtocol {
    func noInternetConnection() {
        
    }
}
