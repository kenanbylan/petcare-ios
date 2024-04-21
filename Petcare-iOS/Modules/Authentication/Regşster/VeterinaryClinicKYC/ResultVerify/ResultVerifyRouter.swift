//
//  ResultVerifyRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation
import UIKit

protocol ResultVerifyRouterProtocol: AnyObject {
    func backToLogin() -> Void
}

final class ResultVerifyRouter: ResultVerifyRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> ResultVerifyViewController {
 
        let view = ResultVerifyViewController()
        let router = ResultVerifyRouter(navigationController: navigationController)
        let interactor = ResultVerifyInteractor()
        let presenter = ResultVerifyPresenter(view: view, router: router, interactor: interactor)

        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func backToLogin() {
    }
}
