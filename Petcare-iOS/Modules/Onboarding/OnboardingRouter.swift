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
        _ = UIStoryboard(name: Constants.Storyboard.onboarding, bundle: nil)
        let view = OnboardingView(frame: UIScreen.main.bounds)
        let viewController = OnboardingViewController(uiView: view)

        viewController.view = view
        viewController.viewDelegate = view
      
        let router = OnboardingRouter(window: window)
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(view: viewController, router: router, interactor: interactor)
        
        viewController.presenter = presenter
        view.controller = viewController
        interactor.output = presenter
        
        return viewController
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
