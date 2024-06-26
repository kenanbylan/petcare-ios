//
//  DocumentVerifyRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.

import Foundation
import UIKit

protocol DocumentVerifyRouterProtocol: AnyObject {
    func navigateToResult(data: UserRegisterRequest) -> Void
}

final class DocumentVerifyRouter: DocumentVerifyRouterProtocol {
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    static func build(navigationController: UINavigationController?, window: UIWindow?, data: UserRegisterRequest) -> DocumentVerifyViewController {
        let view = DocumentVerifyViewController()
        let router = DocumentVerifyRouter(navigationController: navigationController, window: window)
        
        let interactor = DocumentVerifyInteractor(networkService: DefaultNetworkService())
        let presenter = DocumentVerifyPresenter(view: view, router: router, interactor: interactor, data: data)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func navigateToResult(data: UserRegisterRequest) {
        let accountEnable = EmailVerificationRouter.build(navigationController: navigationController, emailAddress: data.email)
        self.navigationController?.pushViewController(accountEnable, animated: true)
    }
}
