//
//  AddressVerifyRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation
import UIKit

protocol AddressVerifyRouterProtocol: AnyObject {
    func backToLogin() -> Void
    func navigateToDocumentVerify(data: UserRegisterRequest) -> Void
}

final class AddressVerifyRouter: AddressVerifyRouterProtocol {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?, userInfo: UserRegisterRequest?) -> AddressVerifyViewController {
        let view = AddressVerifyViewController()
        let router = AddressVerifyRouter(navigationController: navigationController,window: window)
        let interactor = AddressVerifyInteractor()
        let presenter = AddressVerifyPresenter(view: view, router: router, interactor: interactor, userInfo: userInfo)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func backToLogin() { }
    
    func navigateToDocumentVerify(data: UserRegisterRequest) {
        let documentVerify = DocumentVerifyRouter.build(navigationController: navigationController, window: window, data: data)
        navigationController?.pushViewController(documentVerify, animated: true)
    }
}
