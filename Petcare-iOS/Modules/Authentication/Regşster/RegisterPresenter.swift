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
    func navigateAccountEnable(email: String) -> Void
    
    func isMatchPassword(password: String, confirmPassword: String) -> Bool
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
    
    func navigateAccountEnable(email: String) {
        router?.navigateAccountEnable(email: email)
    }
    
    func isMatchPassword(password: String, confirmPassword: String) -> Bool {
        guard password.count >= 8 else { return false }
        guard password == confirmPassword else { return false }
        
        return true
    }
    
    func navigateToVetAddress() {
        router?.navigateToVetAddress()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func registrationSuccess() {
        //MARK: -Kayıt başarılı diye bir mesaj alıp ardından login ekranına yönlendirilecektir.
    }
    
    func registrationFailure(error: Error) {

    }

}
