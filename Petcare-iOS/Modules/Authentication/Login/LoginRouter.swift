//
//  LoginRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import UIKit.UINavigationController

protocol LoginRouterProtocol: AnyObject {
    
}

final class LoginRouter: LoginRouterProtocol {
//    var navigationController: UINavigationController?
//    
//    init(navigationController: UINavigationController?) {
//        self.navigationController = navigationController
//    }
    
    static func build(navigationController: UINavigationController?) -> LoginViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.login, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.login) as! LoginViewController

        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}
