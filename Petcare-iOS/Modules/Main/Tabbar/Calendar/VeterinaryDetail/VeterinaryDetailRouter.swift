//
//  VeterinaryDetailRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.03.2024.
//


import Foundation
import UIKit.UINavigationController

protocol VeterinaryDetailRouterProtocol: AnyObject {
    func navigateToApprove() -> Void
}

final class VeterinaryDetailRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> VeterinaryDetailViewController {
        let view = VeterinaryDetailViewController()
        let router = VeterinaryDetailRouter(navigationController: navigationController)
        let interactor = VeterinaryDetailInteractor()
        let presenter = VeterinaryDetailPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension VeterinaryDetailRouter: VeterinaryDetailRouterProtocol {
    func navigateToApprove() {
        
    }
}