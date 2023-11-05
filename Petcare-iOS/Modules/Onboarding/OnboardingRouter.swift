//
//  OnboardingRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    func navigateToLogin() -> Void
}

final class OnboardingRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> OnboardingViewController {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController else {
            fatalError("Could not instantiate OnboardingViewController from storyboard.")
        }
        
        let router = OnboardingRouter(navigationController: navigationController)
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension OnboardingRouter: OnboardingRouterProtocol {
    func navigateToLogin() {
        let loginView = LoginRouter.build(navigationController: navigationController)
        self.navigationController?.pushViewController(loginView, animated: true)
     //   navigationController?.show(loginView, sender: nil)
    }
}
