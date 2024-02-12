//
//  PrivacyPolicyRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol PrivacyPolicyRouterProtocol: AnyObject { }

final class PrivacyPolicyRouter: PrivacyPolicyRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PrivacyPolicyViewController {
        let view = PrivacyPolicyViewController()
        let router = PrivacyPolicyRouter(navigationController: navigationController)
        let interactor = PrivacyPolicyInteractor()
        
        let presenter = PrivacyPolicyPresenter(viewController: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
