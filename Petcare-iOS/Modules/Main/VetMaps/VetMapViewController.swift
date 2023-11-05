//
//  VetMapViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit

protocol VetMapViewProtocol: AnyObject {
        
}

final class VetMapViewController: UIViewController {
    var presenter: VetMapPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

    }
}
