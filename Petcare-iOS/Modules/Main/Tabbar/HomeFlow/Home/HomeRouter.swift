//  HomeRouter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 5.11.2023.

import Foundation
import UIKit.UINavigationController

protocol HomeRouterProtocol: AnyObject {
    func navigateToPetType()
    func navigateToPetDetail(petData: PetResponse)
    
    func navigateToNearbyList(with onlyShow: Bool) -> Void
    func navigateToReminder() -> Void
    func navigateToContractVetList() -> Void
}

final class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> HomeViewController {
        let view = HomeViewController()
        let router = HomeRouter(navigationController: navigationController)
        let interactor = HomeInteractor(networkManager: NetworkManager.shared)
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    func navigateToPetType() {
        let petType = PetTypeRouter.build(navigationController: navigationController)
        self.navigationController?.pushViewController(petType, animated: true)
    }
    
    func navigateToPetDetail(petData: PetResponse) {
        DispatchQueue.main.async {
            let detail = PetDetailRouter.build(navigationController: self.navigationController, petData: petData)
            self.navigationController?.present(detail, animated: true)
        }
    }
    
    func navigateToNearbyList(with onlyShow: Bool) {
        let view =  NearbyListRouter.build(navigationController: self.navigationController)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigateToReminder() {
        let view = ReminderDetailViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigateToContractVetList() {
        let view = ContractVetListRouter.build(navigationController: navigationController)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
