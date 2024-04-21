//
//  RegisterRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.

import Foundation
import UIKit

import Foundation
import UIKit.UINavigationController

protocol RegisterRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func backToLogin() -> Void
    func navigateToForgot() -> Void
    func navigateToVetAddress() -> Void
    func navigateAccountEnable(email: String) -> Void
}

final class RegisterRouter: RegisterRouterProtocol {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?) -> RegisterViewController {
        let view = RegisterViewController()
        let router = RegisterRouter(navigationController: navigationController, window: window)
        let interactor = RegisterInteractor(networkService: DefaultNetworkService())
        let presenter = RegisterPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func navigateToMain() {
        UIView.transition(with: window!, duration: 0.5, options: .layoutSubviews , animations: {
            self.window?.rootViewController = MainTabbar()
        }, completion: nil)
    }
    
    func navigateToForgot() {
        let forgotPass = ForgotPasswordRouter.build(navigationController: navigationController, window: window)
        self.navigationController?.pushViewController(forgotPass, animated: true)
    }
    
    func backToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToVetAddress() {
        let vetAddress = AddressVerifyRouter.build(navigationController: navigationController,window: window)
        self.navigationController?.pushViewController(vetAddress, animated: true)
    }
    
    
    func navigateAccountEnable(email: String) {
        let accountEnable = EmailVerificationRouter.build(navigationController: navigationController, emailAddress: email)
        self.navigationController?.pushViewController(accountEnable, animated: true)
    }
}
