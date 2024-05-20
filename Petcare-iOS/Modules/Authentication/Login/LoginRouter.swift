//
//  LoginRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func navigateToVeterinaryMain() -> Void
    func navigateToSignUp() -> Void
    func navigateToForgotPassword() -> Void
}

final class LoginRouter: LoginRouterProtocol {
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?) -> LoginViewController {
        let view = LoginViewController()
        let router = LoginRouter(navigationController: navigationController, window: window)
        let interactor = LoginInteractor(networkService: DefaultNetworkService())
        let presenter = LoginPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        presenter.router = router
        
        return view
    }
    
    func navigateToMain() {
        DispatchQueue.main.async {
            guard let window = self.window else { return }
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = MainTabbar()
            }, completion: nil)
        }
    }
    
    func navigateToVeterinaryMain() {
        DispatchQueue.main.async {
            guard let window = self.window else { return }
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = VeterinaryTabbar()
            }, completion: nil)
        }
    }
    
    func navigateToSignUp() {
        guard let window = window, let navigationController = navigationController else { return }
        
        let register = RegisterRouter.build(navigationController: navigationController, window: window)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(register, animated: true)
        }
    }
    
    func navigateToForgotPassword() {
        guard let window = window, let navigationController = navigationController else { return }
        let forgotPassword = ForgotPasswordRouter.build(navigationController: navigationController, window: window)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(forgotPassword, animated: true)
        }
    }
}
