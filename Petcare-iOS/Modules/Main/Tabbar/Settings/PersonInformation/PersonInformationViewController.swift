//
//  PersonInformationViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol PersonInformationViewProtocol: AnyObject {
    
}

class PersonInformationViewController: UIViewController {
    var presenter: PersonInformationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Personel Information"
    }
    
}
