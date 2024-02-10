//
//  SettingsRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation
import UIKit.UINavigationController

protocol SettingsRouterProtocol: AnyObject {
    func navigateToDetail(detail: SettingsModel) -> Void
}

final class SettingsRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> SettingsViewController {
        let view = SettingsViewController()
        let router = SettingsRouter(navigationController: navigationController)
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
        case .apperance: break
        case .donateRouter: break
        case .manageNotification: break
        case .privacyPolicy: break
        case .personInformation:
            let vc = PersonInformationRouter.build(navigationController: navigationController)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
