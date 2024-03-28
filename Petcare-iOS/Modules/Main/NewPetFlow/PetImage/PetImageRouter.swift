//
//  PetImageRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.

import UIKit

protocol PetImageRouterProtocol {
    func navigateToResultPage(model: ApproveResultModel)
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
        
            if let tabbarController = navigationController?.tabBarController {
                tabbarController.selectedIndex = 0
                if let navController = tabbarController.viewControllers?[0] as? UINavigationController {
                    print("tabbarController.viewControllers", tabbarController.viewControllers)
                    navController.popViewController(animated: true)
                }
            } else {
                let tabBarController = MainTabbar()
                tabBarController.selectedIndex = 0
                navigationController?.setViewControllers([tabBarController], animated: true)
            }
    }
    
    func navigateToResultPage(model: ApproveResultModel) {
        let approveResultViewController = ApproveResultViewController(with: model)
        navigationController?.pushViewController(approveResultViewController, animated: true)
    }
}
