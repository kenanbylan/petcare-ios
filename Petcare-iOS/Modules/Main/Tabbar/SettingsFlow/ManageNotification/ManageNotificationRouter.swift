//
//  ManageNotificationRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol ManageNotificationRouterProtocol: AnyObject { }

final class ManageNotificationRouter: ManageNotificationRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> ManageNotificationViewController {
        let view = ManageNotificationViewController()
        let router = ManageNotificationRouter(navigationController: navigationController)
        let interactor = ManageNotificationInteractor()
        
        let presenter = ManageNotificationPresenter(viewController: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
