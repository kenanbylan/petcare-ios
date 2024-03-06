//
//  PetTypePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.
//

import Foundation

protocol PetTypePresenterProtocol {
    func viewDidLoad()
    func navigateToPetInfo()
}

final class PetTypePresenter {
    private weak var view: PetTypeViewProtocol?
    let router: PetTypeRouterProtocol?
    let interactor: PetTypeInteractorProtocol?
    
    init(view: PetTypeViewProtocol? = nil, router: PetTypeRouterProtocol?, interactor: PetTypeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension PetTypePresenter: PetTypePresenterProtocol {
    func navigateToPetInfo() {
        router?.navigateToPetInfo()
    }
    
    func viewDidLoad() {
        
    }
}

extension PetTypePresenter: PetTypeInteractorOutput {
    
}
