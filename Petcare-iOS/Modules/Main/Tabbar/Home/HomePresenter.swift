//
//  HomePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//
import Foundation

protocol HomePresenterProtocol {
    func viewDidLoad()
    func navigateToPetType()
    func navigateToPetDetail(detail: IndexPath)
    
    func navigateToNearbyList(onlyShow: Bool) -> Void
    func navigateToReminder() -> Void
}

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    let router: HomeRouterProtocol?
    let interactor: HomeInteractorProtocol?
    
    init(view: HomeViewProtocol? , router: HomeRouterProtocol?, interactor: HomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    func navigateToNearbyList(onlyShow: Bool) {
        router?.navigateToNearbyList(with: onlyShow)
    }
    
    func navigateToReminder() {
        router?.navigateToReminder()
    }
    
    func navigateToPetDetail(detail: IndexPath) {
        router?.navigateToPetDetail()
    }
    
    func navigateToPetType() {
        router?.navigateToPetType()
    }

    func viewDidLoad() {
        view?.prepareUI()
    }
}

extension HomePresenter: HomeInteractorOutput {
    
}
