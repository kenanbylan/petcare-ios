//
//  DateListInfoDetailRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//

import Foundation
import UIKit

protocol DateListInfoDetailRouterProtocol: AnyObject {
    func backtoMain() -> Void
}

final class DateListInfoDetailRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> DateListInfoDetailViewController {
        let view = DateListInfoDetailViewController()
        let router = DateListInfoDetailRouter(navigationController: navigationController)
        let interactor = DateListInfoDetailInteractor()
        let presenter = DateListInfoDetailPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension DateListInfoDetailRouter: DateListInfoDetailRouterProtocol {
    func backtoMain() {
        
    }
}
