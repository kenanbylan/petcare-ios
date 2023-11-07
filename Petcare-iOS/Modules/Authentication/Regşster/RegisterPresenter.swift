//
//  RegisterPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation


protocol RegisterPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func navigateToLogin() -> Void
}

final class RegisterPresenter {
    private weak var view: RegisterViewProtocol?
    let router: RegisterRouterProtocol?
    let interactor: RegisterInteractorProtocol?
    
    init(view: RegisterViewProtocol?, router: RegisterRouterProtocol?, interactor: RegisterInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func viewDidLoad() { }
    
    func navigateMain() {
        router?.navigateToMain()
    }
    
    func navigateToLogin() {
        router?.backToLogin()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func internetConnectionStatus(_ status: Bool) {
        
    }
    
}
