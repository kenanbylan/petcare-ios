//
//  SplashRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import Foundation
import UIKit

enum SplashRoutes {
    case homeScreen
    case onboardingScreen
    case loginScreen
}

protocol SplashRouterInterface: AnyObject {
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter {
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension SplashRouter : SplashRouterInterface {
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .homeScreen:
            break
        case .onboardingScreen:
            guard let window = viewController?.view.window else { return }
            let onboardingVC = OnboardingRouter().navigate(navigationController: UINavigationController())
            window.rootViewController = onboardingVC
        case .loginScreen:
            break
        }
    }
}
