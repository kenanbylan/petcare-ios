//  ForgotPasswordRouter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 7.11.2023.

import Foundation
import UIKit

protocol ForgotPasswordRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func backToLogin() -> Void
}

final class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?) -> ForgotPasswordViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.forgotPassword, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.forgotpassword) as! ForgotPasswordViewController

        let router = ForgotPasswordRouter(navigationController: navigationController, window: window)
        
        let interactor = ForgotPasswordInteractor()
  
        let presenter = ForgotPasswordPresenter(view: view, router: router, interactor: interactor)

        
        view.presenter = presenter as! any ForgotPasswordPresenterProtocol
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
    
    
    
    
}
