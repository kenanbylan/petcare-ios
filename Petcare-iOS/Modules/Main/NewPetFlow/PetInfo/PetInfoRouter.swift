//
//  PetInfoViewRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

protocol PetInfoRouterProtocol {
    func navigatePetFlowResult() -> Void
    func navigateSelectPetImage() -> Void
}

final class PetInfoRouter {
    var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PetInfoViewController {
        
        let view = PetInfoViewController()
        let router = PetInfoRouter(navigationController: navigationController)
        let interactor = PetInfoInteractor()
        let presenter = PetInfoPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension PetInfoRouter: PetInfoRouterProtocol {
    func navigatePetFlowResult() {
        
    }
    
    func navigateSelectPetImage() {
        let petSelectImageVC = PetImageRouter.build(navigationController: navigationController)
        navigationController?.pushViewController(petSelectImageVC, animated: true)
    }
}
