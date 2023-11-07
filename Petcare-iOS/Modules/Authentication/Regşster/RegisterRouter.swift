//
//  RegisterRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.

import Foundation
import UIKit

import Foundation
import UIKit.UINavigationController

protocol RegisterRouterProtocol: AnyObject {
    func navigateToMain() -> Void
    func backToLogin() -> Void
}

final class RegisterRouter: RegisterRouterProtocol, LoginRouterProtocol {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?,window: UIWindow?) -> RegisterViewController {
        let storyboard = UIStoryboard(name: Constants.Storyboard.register, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: Constants.Controller.register) as! LoginViewController
        
        let router = RegisterRouter(navigationController: navigationController, window: window)
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
    
    func backToLogin() {
        //        let artistPage = ArtistListPageRouter.createModule(navigationController: navigationController,
        //                                                           genreID: id,
        //                                                           genreName: genreName)
        //        self.navigationController?.pushViewController(artistPage, animated: true)
    }
}
