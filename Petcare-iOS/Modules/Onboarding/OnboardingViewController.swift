//
//  OnboardingViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func prepareUI()
}

final class OnboardingViewController: UIViewController {
    
    //MARK: - UIProperty
    @IBOutlet weak var nextButton: UIButton!
    var presenter: OnboardingPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        nextButton.setTitle("Next to Login Pages", for: .normal)
    }
    
    //MARK: UIActions
    @IBAction func NextButtonTapped(_ sender: Any) {
        //MARK: NAVİGATE TO LOGİN OR REGİSTER
        print("Next button clicked")
        presenter?.navigateToLogin()

    }
    
}

extension OnboardingViewController: OnboardingViewProtocol {
    func prepareUI() {
        view.backgroundColor = .systemGreen
    }
}
