//
//  PetImageRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

protocol PetImageRouterProtocol {
    func navigateToResultPage() -> Void
    func navigateToMainTabbar() -> Void
}

final class PetImageRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PetImageViewController {
        let view = PetImageViewController()
        let router = PetImageRouter(navigationController: navigationController)
        let interactor = PetImageInteractor()
        let presenter = PetImagePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}


extension PetImageRouter: PetImageRouterProtocol {
    func navigateToMainTabbar() {
        
    }
    
    func navigateToResultPage() {
        
    }
}
