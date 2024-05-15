//
//  PetImageRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.

import UIKit

protocol PetImageRouterProtocol {
    func navigateToMainTabbar() -> Void
}

final class PetImageRouter {
    var navigationController: UINavigationController?
    var petInfoData: PetInfoModel?
    
    init(navigationController: UINavigationController? = nil, petInfoData: PetInfoModel? = nil) {
        self.navigationController = navigationController
        self.petInfoData = petInfoData
    }
    
    static func build(navigationController: UINavigationController?, petInfoData: PetInfoModel) -> PetImageViewController {
        let view = PetImageViewController()
        let router = PetImageRouter(navigationController: navigationController)
        let interactor = PetImageInteractor(networkManager: NetworkManager.shared)
        let presenter = PetImagePresenter(view: view, router: router, interactor: interactor, petInfoData: petInfoData)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}


extension PetImageRouter: PetImageRouterProtocol {
    func navigateToMainTabbar() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
