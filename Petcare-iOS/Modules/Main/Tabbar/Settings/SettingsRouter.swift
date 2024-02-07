//
//  SettingsRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation
import UIKit.UINavigationController

protocol SettingsRouterProtocol: AnyObject {
    
}

final class SettingsRouter: SettingsRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> SettingsViewController {
//        let storyboard = UIStoryboard(name: Constants.Storyboard.settings, bundle: nil)
//        let view = storyboard.instantiateViewController(identifier: Constants.Controller.settings) as! SettingsViewController
        let view = SettingsViewController()
        let router = SettingsRouter(navigationController: navigationController)
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
