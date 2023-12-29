//
//  SplashRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import Foundation
import UIKit

protocol SplashRouterProtocol: AnyObject {
    func navigateToOnboarding() -> Void
    func navigateToLogin() -> Void
    func navigateToHome() -> Void
}

final class SplashRouter {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    static func build(in window: UIWindow) -> SplashViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.splash, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: Constants.Controller.splash) as? SplashViewController else {
            fatalError("Could not instantiate SplashViewController from storyboard.")
        }
        let router = SplashRouter(window: window)
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigateToOnboarding() {
        let onboardingVC = OnboardingRouter.build(in: window)
        let navigationController = UINavigationController(rootViewController: onboardingVC)
        window.rootViewController = navigationController
    }
    
    func navigateToLogin() {
        let navigationController = UINavigationController()
        let loginVC = LoginRouter.build(navigationController: navigationController , window: window)
        navigationController.viewControllers.append(loginVC)
        window.rootViewController = navigationController
    }
    
    func navigateToHome() {
        let navigationController = UINavigationController()
//        let loginVC = HomeRouter.build(navigationController: navigationController , window: window)
        let homeVC = HomeRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(homeVC)
        window.rootViewController = navigationController
    }
}
