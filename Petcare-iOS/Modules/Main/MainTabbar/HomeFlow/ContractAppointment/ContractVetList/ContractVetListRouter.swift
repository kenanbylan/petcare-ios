//
//  ContractVetListRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation
import UIKit.UINavigationController


protocol ContractVetListRouterProtocol: AnyObject {
    func navigateToLogin() -> Void
    func navigateToDetail(data: UserRegisterRequest) -> Void
    func navigateToHistory() -> Void
    static func build(navigationController: UINavigationController?) -> ContractVetListViewController
}


final class ContractVetListRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> ContractVetListViewController {
        let view = ContractVetListViewController()
        let router = ContractVetListRouter(navigationController: navigationController)
        let interactor = ContractVetListInteractor(networkManager: NetworkManager.shared)
        
        let presenter = ContractVetListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension ContractVetListRouter: ContractVetListRouterProtocol {
    func navigateToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func navigateToDetail(data: UserRegisterRequest) {
//        let view = VeterinaryDetailRouter.build(navigationController: navigationController, data: data)
//        navigationController?.pushViewController(view, animated: true)
    }
    
    func navigateToHistory() {
        let view = AppointmentHistoryRouter.build(navigationController: navigationController)
        navigationController?.pushViewController(view, animated: true)
    }
}
