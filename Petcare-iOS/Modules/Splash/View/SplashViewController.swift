//
//  SplashViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import UIKit

protocol SplashViewControllerInterface: AnyObject {
    func noInternetConnection()
    func deviceControl()
}

class SplashViewController: UIViewController {
    var presenter: SplashPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
     }
}

extension SplashViewController: SplashViewControllerInterface {
    func noInternetConnection() {
        #warning("Will add Custom Alert Message!")
    }
    
    func deviceControl() { }
}
