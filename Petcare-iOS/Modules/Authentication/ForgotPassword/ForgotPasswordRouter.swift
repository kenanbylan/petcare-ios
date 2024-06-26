//  ForgotPasswordRouter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 7.11.2023.

import Foundation
import UIKit

protocol ForgotPasswordRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func backToLogin() -> Void
    func navigateToSendCode(email: String) -> Void
}

final class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?) -> ForgotPasswordViewController {
        let view = ForgotPasswordViewController()
        let router = ForgotPasswordRouter(navigationController: navigationController, window: window)
        let interactor = ForgotPasswordInteractor(networkService: DefaultNetworkService())
        let presenter = ForgotPasswordPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func navigateToMain() {
        UIView.transition(with: window!, duration: 0.5, options: .layoutSubviews , animations: {
            self.window?.rootViewController = MainTabbar()
        }, completion: nil)
    }
    
    func backToLogin() {
        let navigationController = UINavigationController()
        let loginVC = LoginRouter.build(navigationController: navigationController , window: window)
        navigationController.viewControllers.append(loginVC)
        window?.rootViewController = navigationController
    }
    
    
    func navigateToSendCode(email: String) {
        let accountEnable = EmailVerificationRouter.build(navigationController: self.navigationController, emailAddress: email, resetPassword: true)
        self.navigationController?.pushViewController(accountEnable, animated: true)
    }
}
