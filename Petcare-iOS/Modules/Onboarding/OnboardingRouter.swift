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
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    static func build(in window: UIWindow) -> OnboardingViewController {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController else {
            fatalError("Could not instantiate OnboardingViewController from storyboard.")
        }
        
        let router = OnboardingRouter(window: window)
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension OnboardingRouter: OnboardingRouterProtocol {
    func navigateToLogin() {
        let navigationController = UINavigationController()
        let loginVC = LoginRouter.build(navigationController: navigationController , window: window)
        navigationController.viewControllers.append(loginVC)
        window.rootViewController = navigationController
    }
}
