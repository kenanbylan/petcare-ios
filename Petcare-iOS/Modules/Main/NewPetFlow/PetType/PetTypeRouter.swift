//
//  PetTypeRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.
//

import UIKit.UINavigationController

protocol PetTypeRouterProtocol: AnyObject {
    func navigateToBreed() -> Void
    func navigateToPetInfo() -> Void
}

final class PetTypeRouter: PetTypeRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PetTypeController {
        let view = PetTypeController()
        let router = PetTypeRouter(navigationController: navigationController)
        let interactor = PetTypeInteractor()
        let presenter = PetTypePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
    
        return view
    }
    
    func navigateToBreed() { }
    
    func navigateToPetInfo() {
        let petInfoVC = PetInfoRouter.build(navigationController: navigationController)
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
}
