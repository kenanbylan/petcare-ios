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
    func navigateToForgotPassword() -> Void
    func validateFields(name: String?, last: String?, email: String?, password: String?, confirmPassword: String?)
    func registerUser(name: String, surname: String, email: String, password: String)
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
    func registerUser(name: String, surname: String, email: String, password: String) {
        //MARK: - Öncelikle validation yapılacaktır.
        interactor?.registerUser(name: name, surname: surname, email: email, password: password)
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
    
    func validateFields(name: String?, last: String?, email: String?, password: String?, confirmPassword: String?) {
        
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func registrationSuccess() {
        //MARK: -Kayıt başarılı diye bir mesaj alıp ardından login ekranına yönlendirilecektir.
    }
    
    func registrationFailure(error: Error) {

    }

}
