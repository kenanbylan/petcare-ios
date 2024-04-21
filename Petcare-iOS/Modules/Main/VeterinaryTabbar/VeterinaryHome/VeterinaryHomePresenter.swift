//
//  VeterinaryHomePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol VeterinaryHomePresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func backToLogin() -> Void
}

final class VeterinaryHomePresenter {
    private weak var view: VeterinaryHomeViewController?
    private let router: VeterinaryHomeRouterProtocol?
    private let interactor: VeterinaryHomeInteractorProtocol?
    
    init(view: VeterinaryHomeViewController?, router: VeterinaryHomeRouterProtocol?, interactor: VeterinaryHomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension VeterinaryHomePresenter: VeterinaryHomePresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func navigateMain() {
        
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
}


extension VeterinaryHomePresenter: VeterinaryHomeInteractorOutput {
    
}
