//
//  PetImagePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import Foundation

protocol PetImagePresenterProtocol {
    func viewDidLoad() -> Void
    func dismissScreen() -> Void
    func navigateMainPage() -> Void
}

final class PetImagePresenter {
    private weak var view: PetImageViewProtocol?
    let router: PetImageRouterProtocol?
    let interactor: PetImageInteractorProtocol?
    
    init(view: PetImageViewProtocol?, router: PetImageRouterProtocol?, interactor: PetImageInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}


extension PetImagePresenter: PetImagePresenterProtocol {
    func navigateMainPage() {
        router?.navigateToMainTabbar()
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func dismissScreen() {
        
    }
}

extension PetImagePresenter: PetImageInteractorOutput {
    
}
