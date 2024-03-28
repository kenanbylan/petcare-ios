//
//  PetDetailRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import UIKit

protocol PetDetailProtocol {
    func dissmis()
}

final class PetDetailRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> PetDetailViewController {
        let view = PetDetailViewController()
        let router = PetDetailRouter(navigationController: navigationController)
        let interactor = PetDetailInteractor()
        let presenter = PetDetailPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension PetDetailRouter: PetDetailProtocol {
    func dissmis() {
    }
    
    
}
