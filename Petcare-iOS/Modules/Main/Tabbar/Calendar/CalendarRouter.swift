//
//  CalendarRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation


import Foundation
import UIKit.UINavigationController

protocol CalendarRouterProtocol: AnyObject {
}

final class CalendarRouter: CalendarRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> CalendarViewController {
        let view = CalendarViewController()
        let router = CalendarRouter(navigationController: navigationController)
        let interactor = CalendarInteractor()
        let presenter = CalendarPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    
}
