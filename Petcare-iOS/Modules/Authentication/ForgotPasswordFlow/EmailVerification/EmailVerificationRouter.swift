//
//  EmailVerificationRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation
import UIKit

protocol EmailVerificationRouterProtocol: AnyObject {
    func navigateToLogin() -> Void
}

final class EmailVerificationRouter: EmailVerificationRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?, emailAddress: String?) -> EmailVerificationViewController {
        let view = EmailVerificationViewController()
        let router = EmailVerificationRouter(navigationController: navigationController )
        let interactor = EmailVerificationInteractor(networkService: DefaultNetworkService())
        let presenter = EmailVerificationPresenter(view: view, router: router, interactor: interactor,emailAddress: emailAddress)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    func navigateToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
}
