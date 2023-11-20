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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        
    }
}

extension HomeViewController: HomeViewProtocol {
    
    
}


