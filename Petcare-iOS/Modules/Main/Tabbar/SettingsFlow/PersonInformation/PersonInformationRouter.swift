//
//  PersonInformationRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.

import UIKit

protocol PersonInformationRouterProtocol: AnyObject {
    func navigateToRoot()
}

final class PersonInformationRouter: PersonInformationRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PersonInformationViewController {
        let view = PersonInformationViewController()
        let router = PersonInformationRouter(navigationController: navigationController)
        
        let interactor = PersonInformationInteractor(networkManager: NetworkManager.shared)
        let presenter = PersonInformationPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    func navigateToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
