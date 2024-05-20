//
//  CalendarRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation


import Foundation
import UIKit.UINavigationController

protocol CalendarRouterProtocol: AnyObject {
    func navigateToNearbyList(with onlyShow: Bool) -> Void
    func navigateToReminder() -> Void
}

final class CalendarRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> CalendarViewController {
        let view = CalendarViewController()
        let router = CalendarRouter(navigationController: navigationController)
        let interactor = CalendarInteractor()
        let presenter = CalendarPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension CalendarRouter: CalendarRouterProtocol {
    func navigateToNearbyList(with onlyShow: Bool) {
        let view =  NearbyListRouter.build(navigationController: navigationController)
        navigationController?.pushViewController(view, animated: true)
    }
    
    func navigateToReminder() -> Void {
        let view = ReminderRouter.build(navigationController: navigationController)
        navigationController?.pushViewController(view, animated: true)
    }
}
