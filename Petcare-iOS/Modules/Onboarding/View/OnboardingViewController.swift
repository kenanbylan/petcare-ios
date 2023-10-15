//
//  OnboardingViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import UIKit


protocol OnboardingViewInterface: AnyObject {
    func prepareUI()
    func setTitle(_ title: String)
}

class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension OnboardingViewController : OnboardingViewInterface {
    func prepareUI() {
        view.backgroundColor = .red
    }
    
    func setTitle(_ title: String) {
        navigationItem.title = title
    }
    
}
