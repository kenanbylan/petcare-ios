//
//  HomeViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
}

class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        presenter?.navigatetoOnboarding()
    }
}

extension HomeViewController: HomeViewProtocol {
}
