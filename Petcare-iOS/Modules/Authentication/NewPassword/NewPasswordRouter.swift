//
//  NewPasswordRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.02.2024.
//

import Foundation
import UIKit

protocol NewPasswordRouterProtocol: AnyObject {
    func navigateToLogin() -> Void
}

final class NewPasswordRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?, email: String) -> NewPasswordViewController {
        let view = NewPasswordViewController()
        let router = NewPasswordRouter(navigationController: navigationController)
        
        let interactor = NewPasswordInteractor(networkService: DefaultNetworkService())
        let presenter = NewPasswordPresenter(view: view, router: router, interactor: interactor,existEmail: email)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension NewPasswordRouter: NewPasswordRouterProtocol {
    func navigateToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
}
