//
//  AppointmentHistoryRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation
import UIKit.UINavigationController

protocol AppointmentHistoryRouterProtocol: AnyObject {
    func navigateToLogin() -> Void
    static func build(navigationController: UINavigationController?) -> AppointmentHistoryViewController
}

final class AppointmentHistoryRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> AppointmentHistoryViewController {
        let view = AppointmentHistoryViewController()
        let router = AppointmentHistoryRouter(navigationController: navigationController)
        let interactor = AppointmentHistoryInteractor()
        let presenter = AppointmentHistoryPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension AppointmentHistoryRouter: AppointmentHistoryRouterProtocol {
    func navigateToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
}
