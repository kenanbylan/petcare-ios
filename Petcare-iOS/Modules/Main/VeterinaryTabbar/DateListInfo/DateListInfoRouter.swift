//
//  DateListInfoRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import Foundation
import UIKit

protocol DateListInfoRouterProtocol: AnyObject {
    func dateInformationData() -> Void
}

final class DateListInfoRouter: DateListInfoRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> DateListInfoViewController {
        let view = DateListInfoViewController()
        
        let router = DateListInfoRouter(navigationController: navigationController)
        let interactor = DateListInfoInteractor()
        let presenter = DateListInfoPresenter(view: view, router: router, interactor: interactor)

        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func dateInformationData() {
        //MARK: Will be change's
    }
}
