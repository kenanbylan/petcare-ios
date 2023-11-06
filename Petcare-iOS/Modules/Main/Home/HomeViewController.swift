//
//  HomeViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import SwiftUI

protocol HomeViewProtocol: AnyObject {
    
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    var headerView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 80).isActive = true // Özelleştirin
        
    }
    
    //    @IBAction func nextButtonTapped(_ sender: Any) {
    //        presenter?.navigatetoOnboarding()
    //    }
    
}

extension HomeViewController: HomeViewProtocol {
    
    
}


