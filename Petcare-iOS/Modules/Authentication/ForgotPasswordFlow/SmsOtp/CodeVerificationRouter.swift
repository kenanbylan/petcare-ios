//
//  CodeVerificationRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.02.2024.
//

import Foundation
import UIKit


protocol CodeVerificationRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func backToLogin() -> Void
}

final class CodeVerificationRouter: CodeVerificationRouterProtocol {
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?) -> CodeVerificationViewController {
        let view = CodeVerificationViewController()
        let router = CodeVerificationRouter(navigationController: navigationController, window: window)
        let interactor = CodeVerificationInteractor(networkService: DefaultNetworkService())
        let presenter = CodeVerificationPresenter(view: view, router: router, interactor: interactor)
        
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
 
}
