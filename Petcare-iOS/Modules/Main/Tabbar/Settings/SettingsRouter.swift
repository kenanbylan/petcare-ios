//
//  SettingsRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation
import UIKit

protocol SettingsRouterProtocol: AnyObject {
    func navigateToDetail(detail: SettingsModel) -> Void
}

final class SettingsRouter {
    var navigationController: UINavigationController?
    var window: UIWindow
        
    init(navigationController: UINavigationController? = nil, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow) -> SettingsViewController {
        let view = SettingsViewController()
        let router = SettingsRouter(navigationController: navigationController,window: window)
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension SettingsRouter: SettingsRouterProtocol {
    func navigateToDetail(detail: SettingsModel) {
        
        switch detail.router {
        case .apperance:
            let vc = AppearanceRouter.build(navigationController: navigationController)
            navigationController?.pushViewController(vc, animated: true)
            
        case .donateRouter:
            let vc = DonateRouter.build(navigationController: navigationController)
            navigationController?.pushViewController(vc, animated: true)
            
        case .manageNotification:
            let vc = ManageNotificationRouter.build(navigationController: navigationController)
            navigationController?.pushViewController(vc, animated: true)
            
        case .privacyPolicy:
            let vc = PrivacyPolicyRouter.build(navigationController: navigationController)
            navigationController?.pushViewController(vc, animated: true)
            
        case .personInformation:
            let vc = PersonInformationRouter.build(navigationController: navigationController)
            navigationController?.pushViewController(vc, animated: true)
        case .signOut:
            break
//            let navigationController = UINavigationController()
//            let loginVC = LoginRouter.build(navigationController: navigationController , window: window)
//            navigationController.viewControllers.append(loginVC)
//            window.rootViewController = navigationController
        }
    }
}
