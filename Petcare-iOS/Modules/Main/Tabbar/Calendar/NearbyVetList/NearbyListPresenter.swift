//
//  NearbyListPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import Foundation

protocol NearbyListPresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
    func navigateToDetail(data: NearbyPlace)
}

final class NearbyListPresenter {
    private weak var view: NearbyListViewController?
    var title: String = "Nearby List Veterinary"
    let router: NearbyListRouterProtocol?
    let interactor: NearbyListInteractorProtocol?
    
    init(view: NearbyListViewController?, router: NearbyListRouterProtocol?, interactor: NearbyListInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setTitle() -> String {
        return self.title
    }
}

extension NearbyListPresenter: NearbyListPresenterProtocol {
    func viewDidLoad() {
        interactor?.getTableViewList()
        view?.prepareTitle()
    }
    
    func navigateToDetail(data: NearbyPlace) {
        router?.navigateToDetail(data: data)
    }
}

extension NearbyListPresenter: NearbyListInteractOutput {
    
}
