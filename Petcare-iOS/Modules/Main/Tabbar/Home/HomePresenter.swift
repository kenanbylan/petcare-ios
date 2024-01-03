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
}

final class HomePresenter {
    private weak var view : HomeViewProtocol?
    let router: HomeRouterProtocol?
    let interactor: HomeInteractorProtocol?
    
    init(view: HomeViewProtocol? , router: HomeRouterProtocol?, interactor: HomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    func navigateToPetType() {
        router?.navigateToPetType()
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
}

extension HomePresenter: HomeInteractorOutput {
    
}
