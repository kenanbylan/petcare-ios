//
//  PetInfoViewRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

protocol PetInfoRouterProtocol {
    func navigateSelectPetImage(_ data: PetInfoModel) -> Void
}

final class PetInfoRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?, selectedPet: String) -> PetInfoViewController {
        let view = PetInfoViewController()
        let router = PetInfoRouter(navigationController: navigationController)
        let interactor = PetInfoInteractor()
        let presenter = PetInfoPresenter(view: view, router: router, interactor: interactor, selectedPet: selectedPet)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension PetInfoRouter: PetInfoRouterProtocol {
    func navigateSelectPetImage(_ data: PetInfoModel) {
        let petSelectImageVC = PetImageRouter.build(navigationController: navigationController, petInfoData: data)
        navigationController?.pushViewController(petSelectImageVC, animated: true)
    }
}
