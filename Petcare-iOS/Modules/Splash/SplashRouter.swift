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
}

final class SplashRouter {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    static func build(in window: UIWindow) -> SplashViewController {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
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
}
