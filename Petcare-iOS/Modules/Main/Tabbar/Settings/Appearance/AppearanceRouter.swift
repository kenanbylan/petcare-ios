//
//  AppearanceRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import UIKit

protocol AppearanceRouterProtocol: AnyObject { }

final class AppearanceRouter: AppearanceRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> AppearanceViewController {
        let view = AppearanceViewController()
        let router = AppearanceRouter(navigationController: navigationController)
        let interactor = AppearanceInteractor()
        
        let presenter = ApperancePresenter(viewController: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
