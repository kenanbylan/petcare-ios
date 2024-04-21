//  LoginPresenter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 14.10.2023.

import Foundation
import Combine
import UIKit

enum LoginState {
    case loading
    case success
    case failed
    case none
}

protocol LoginPresenterProtocol {
    func viewDidload() -> Void
    func navigateMain(data: LoginRequest) -> Void
    func navigateSignUp() -> Void
    func navigateForgotPassword() -> Void
    func navigateToVeterinaryMain() -> Void
    func saveUser(_ user: LoginRequest)
}

final class LoginPresenter: ObservableObject {
    private weak var view: LoginViewController?
    let router: LoginRouterProtocol?
    let interactor: LoginInteractorProtocol?
    
    var userData: LoginRequest?
    
    init(view: LoginViewController? , router: LoginRouterProtocol?, interactor: LoginInteractorProtocol?) {
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
    
    func navigateMain(data: LoginRequest) {
        //burada akış değişecek eğer veteriner ise veterinery akışı değilse normal giriş olacak
        //router?.navigateToMain()
        interactor?.login(user: data)
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
    }
    
    func registrationFailure(error: Error) {
        print("ERROR : \(error.localizedDescription)")
    }
}
