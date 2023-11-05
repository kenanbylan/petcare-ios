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
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> SplashViewController {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
            fatalError("Could not instantiate SplashViewController from storyboard.")
        }
        
        let router = SplashRouter(navigationController: navigationController)

        let interactor = SplashInteractor()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: router)
    
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigateToOnboarding() {
        let onboardingVC = OnboardingRouter.build(navigationController: UINavigationController())
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
}
