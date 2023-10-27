//
//  OnboardingRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import UIKit

protocol OnboardingRouterInterface: AnyObject {
    func navigate(navigationController : UINavigationController) -> OnboardingViewController
}

final class OnboardingRouter: OnboardingRouterInterface {
    func navigate(navigationController: UINavigationController) -> OnboardingViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.onboarding, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: Constants.Controller.onboarding) as? OnboardingViewController else {
            fatalError("Error: OnboardingController not build!!")
        }
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        let presenter = OnboardingPresenter(view: view , router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}
