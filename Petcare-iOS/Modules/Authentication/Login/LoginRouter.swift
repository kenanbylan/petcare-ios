//
//  LoginRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import UIKit.UINavigationController

protocol LoginRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func navigateToSignUp() -> Void
}

final class LoginRouter: LoginRouterProtocol {
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?,window: UIWindow?) -> LoginViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.login, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.login) as! LoginViewController

        let router = LoginRouter(navigationController: navigationController, window: window)
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    
    func navigateToMain() {
        UIView.transition(with: window!, duration: 0.5, options: .layoutSubviews , animations: {
            self.window?.rootViewController = MainTabbar()
        }, completion: nil)
    }

    func navigateToSignUp() {
//        let artistPage = ArtistListPageRouter.createModule(navigationController: navigationController,
//                                                           genreID: id,
//                                                           genreName: genreName)
//        self.navigationController?.pushViewController(artistPage, animated: true)
    }
}
