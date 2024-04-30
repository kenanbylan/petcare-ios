//  LoginPresenter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 14.10.2023.

import Foundation
import UIKit

protocol LoginPresenterProtocol {
    func viewDidload() -> Void
    func navigateMain() -> Void
    func navigateSignUp() -> Void
    func navigateForgotPassword() -> Void
    func navigateToVeterinaryMain() -> Void
    func saveUser(_ user: LoginRequest)
}

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    let router: LoginRouterProtocol?
    let interactor: LoginInteractorProtocol?
    
    var userData: LoginRequest?
    
    init(view: LoginViewProtocol? , router: LoginRouterProtocol?, interactor: LoginInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func saveUser(_ user: LoginRequest) {
        userData = user
    }
    
    func viewDidload() { }
    
    func navigateMain() {
        //interactor?.login(user: userData!)
        router?.navigateToMain()
    }
    
    func navigateToVeterinaryMain() {
        router?.navigateToVeterinaryMain()
    }
    
    func navigateSignUp() {
        router?.navigateToSignUp()
    }
    
    func navigateForgotPassword() {
        router?.navigateToForgotPassword()
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func registrationSuccess(user: LoginResponse) {
        print("Presenter: \(user)")
        //MARK: -eğer login doğru ise gelen role göre user ya veterinery akışına yada user'a gidecektir.
    }
    
    func registrationFailure(error: ExceptionErrorHandle) {
        view?.showAlertMessage(message: error.error ?? "error message is nil")
    }
}
