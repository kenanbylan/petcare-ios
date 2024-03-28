//
//  ReminderRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 17.03.2024.
//

import UIKit.UINavigationController

protocol ReminderRouterProtocol: AnyObject {
    func navigateToHistory() -> Void
}

final class ReminderRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> ReminderViewController {
        let view = ReminderViewController()
        let router = ReminderRouter(navigationController: navigationController)
        
        let interactor = ReminderInteractor()
        let presenter = ReminderPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension ReminderRouter: ReminderRouterProtocol {
    func navigateToHistory() {
        
    }
    
    
}
