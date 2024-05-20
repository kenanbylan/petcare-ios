//
//  VeterinaryHomeRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation
import UIKit

protocol VeterinaryHomeRouterProtocol {
    func navigateToDateList() -> Void
}

final class VeterinaryHomeRouter: VeterinaryHomeRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?) -> VeterinaryHomeViewController {
        let view = VeterinaryHomeViewController()
        let router = VeterinaryHomeRouter(navigationController: navigationController)
        let interactor = VeterinaryHomeInteractor()
        let presenter = VeterinaryHomePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func navigateToDateList() {
        
    }
}
