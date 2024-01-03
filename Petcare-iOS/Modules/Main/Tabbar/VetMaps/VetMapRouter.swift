//
//  VetMapRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation
import UIKit

protocol VetMapRouterProtocol: AnyObject {
    
}

final class VetMapRouter: VetMapRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> VetMapViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.vetmap, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.vetmaps) as! VetMapViewController
        
        let router = VetMapRouter(navigationController: navigationController)
        let interactor = VetMapInteractor()
        let presenter = VetMapPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
