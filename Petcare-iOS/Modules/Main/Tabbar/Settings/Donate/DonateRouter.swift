//
//  DonateRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol DonateRouterProtocol: AnyObject { }

final class DonateRouter: DonateRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> DonateViewController {
        let view = DonateViewController()
        let router = DonateRouter(navigationController: navigationController)
        let interactor = DonateInteractor()
        let presenter = DonatePresenter(viewController: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
