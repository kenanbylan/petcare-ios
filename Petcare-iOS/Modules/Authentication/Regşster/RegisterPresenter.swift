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
    func navigateToVetAddress() -> Void
    func navigateToForgotPassword() -> Void
    func navigateAccountEnable() -> Void
    func saveUser(_ data: UserRegisterRequest)
}

final class RegisterPresenter {
    private weak var view: RegisterViewProtocol?
    let router: RegisterRouterProtocol?
    let interactor: RegisterInteractorProtocol?
    var userData: UserRegisterRequest?
    
    init(view: RegisterViewProtocol?, router: RegisterRouterProtocol?, interactor: RegisterInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func saveUser(_ data: UserRegisterRequest) {
        userData = data
    }
    
    func viewDidLoad() { }
    
    func navigateMain() {
        router?.navigateToMain()
    }
    
    func navigateToLogin() {
        router?.backToLogin()
    }
    
    func navigateToForgotPassword() {
        router?.navigateToForgot()
    }
    
    func navigateAccountEnable() {
        router?.navigateAccountEnable(userInfo: userData!)
    }
    
    func navigateToVetAddress() {
        router?.navigateToVetAddress(userInfo: userData!)
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func registrationSuccess() {
        //MARK: -Kayıt başarılı diye bir mesaj alıp ardından login ekranına yönlendirilecektir.
    }
    
    func registrationFailure(error: Error) {
        
    }
}
