//  LoginPresenter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 14.10.2023.

import Foundation

protocol LoginPresenterProtocol {
    func load()
}

final class LoginPresenter {
    private weak var view : LoginViewControllerProtocol?
    let router: LoginRouterProtocol?
    let interactor: LoginInteractorProtocol?
    
    init(view: LoginViewControllerProtocol? , router: LoginRouterProtocol?, interactor: LoginInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func load() {
        
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func internetConnectionStatus(_ status: Bool) {
        print("data sett loginn")
    }
}
