//
//  PetTypeRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.
//

import UIKit.UINavigationController

protocol PetTypeRouterProtocol: AnyObject {
    func navigateToBreed() -> Void
    func navigateToPetInfo(selectPet: String) -> Void
}

final class PetTypeRouter: PetTypeRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PetTypeViewController {
        let view = PetTypeViewController()
        let router = PetTypeRouter(navigationController: navigationController)
        let interactor = PetTypeInteractor()
        let presenter = PetTypePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    func navigateToBreed() { }
    
    func navigateToPetInfo(selectPet: String) {
        let petInfoVC = PetInfoRouter.build(navigationController: navigationController, selectedPet: selectPet)
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
}
