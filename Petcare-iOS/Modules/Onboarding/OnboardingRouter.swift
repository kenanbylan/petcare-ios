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

        let view = OnboardingView(frame: UIScreen.main.bounds)
        
        let viewVC = OnboardingViewController(uiView: view)

        viewVC.view = view
        viewVC.viewDelegate = view
      
        let router = OnboardingRouter(window: window)
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(view: viewVC, router: router, interactor: interactor)
        
        viewVC.presenter = presenter
        view.controller = viewVC
        interactor.output = presenter
        
        return viewVC
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
