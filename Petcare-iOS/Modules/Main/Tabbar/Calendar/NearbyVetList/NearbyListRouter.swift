//
//  NearbyListRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import Foundation
import UIKit.UINavigationController

protocol NearbyListRouterProtocol: AnyObject {
    func popupNearbyListView() -> Void
    func navigateToDetail(data: NearbyPlace) -> Void
}

final class NearbyListRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> NearbyListViewController {
        let view = NearbyListViewController()
        let router = NearbyListRouter(navigationController: navigationController)
        let interactor = NearbyListInteractor()
        let presenter = NearbyListPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension NearbyListRouter: NearbyListRouterProtocol {
    func popupNearbyListView() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetail(data: NearbyPlace) {
        
    }
}
