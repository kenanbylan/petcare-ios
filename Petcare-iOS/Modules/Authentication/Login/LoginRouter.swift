//
//  LoginRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import UIKit.UINavigationController

protocol LoginRouterProtocol: AnyObject {
    func navigateToMain() -> Void
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
    
    static func build(navigationController: UINavigationController?,window: UIWindow?) -> LoginViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.login, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.login) as! LoginViewController
        
        let router = LoginRouter(navigationController: navigationController, window: window)
        let interactor = LoginInteractor(networkManager: NetworkManager())
        let presenter = LoginPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func navigateToMain() {

        UIView.animate(withDuration: 0.5, animations: {
                self.window?.rootViewController = MainTabbar()
            }, completion: nil)
    }
 
    func navigateToSignUp() {
        let register = RegisterRouter.build(navigationController: navigationController, window: window)
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    func navigateToForgotPassword() {
        let forgotPassword = ForgotPasswordRouter.build(navigationController: navigationController, window: window)
        self.navigationController?.pushViewController(forgotPassword, animated: true)
    }
}
