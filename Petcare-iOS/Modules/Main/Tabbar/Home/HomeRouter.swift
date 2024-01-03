//  HomeRouter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 5.11.2023.

import Foundation
import UIKit.UINavigationController

protocol HomeRouterProtocol: AnyObject {
    func navigateToPetType()
}

final class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> HomeViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.home, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.home) as! HomeViewController

        let router = HomeRouter(navigationController: navigationController)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    
    func navigateToPetType() {
        let petType = PetTypeRouter.build(navigationController: navigationController)
        
        self.navigationController?.pushViewController(petType, animated: true)
    }
    
    
}
