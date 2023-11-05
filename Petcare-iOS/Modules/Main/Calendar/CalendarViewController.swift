//
//  CalendarViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit

protocol CalendarViewProtocol: AnyObject {
    
}

class CalendarViewController: UIViewController {
    var presenter: CalendarPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }

}
