//
//  VeterinarySettingsRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation
import UIKit

protocol VeterinarySettingsRouterProtocol: AnyObject {
    func backToLogin() -> Void
    func navigateToDetail(detail: DayModel?)
}

final class VeterinarySettingsRouter: VeterinarySettingsRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> VeterinarySettingsViewController {
        let view = VeterinarySettingsViewController()
        let router = VeterinarySettingsRouter(navigationController: navigationController)
        let interactor = VeterinarySettingsInteractor()
        let presenter = VeterinarySettingsPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func backToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func navigateToDetail(detail: DayModel?) {
        let vc = DateListInfoDetailRouter.build(navigationController: navigationController)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
