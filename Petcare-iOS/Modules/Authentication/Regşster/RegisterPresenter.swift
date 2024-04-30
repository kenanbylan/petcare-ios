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
    func registerAccount(_ data: UserRegisterRequest)
    func navigateToEmailAddress() -> Void
    func fetchRequest() -> Void
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
    func registerAccount(_ data: UserRegisterRequest) {
        interactor?.registerUser(registerUser: data)
    }
    
    func saveUser(_ data: UserRegisterRequest) {
        userData = data
    }
    
    func fetchRequest() {
        guard let userData = userData else { return }
        interactor?.registerUser(registerUser: userData)
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
        guard let userData = userData else { return }
        interactor?.registerUser(registerUser: userData)
    }
    
    func navigateToEmailAddress() {
        router?.navigateAccountEnable(userInfo: userData!)
    }
    
    func navigateToVetAddress() {
        router?.navigateToVetAddress(userInfo: userData!)
    }
}


extension RegisterPresenter: RegisterInteractorOutput {
    //TODO: - Ask here
    func registrationSuccess(response: UserRegisterResponse) {
        if !(response.message == nil)  {
            if userData?.role == .USER {
                self.view?.showAlertMessage(message: response.message ??  "TEST", type: .USER)
            } else if userData?.role == .VETERINARY {
                self.view?.showAlertMessage(message: response.message ??  "TEST", type: .VETERINARY)
                router?.navigateToVetAddress(userInfo: userData!)
            }
        }
        view?.showAlertFailure(message: response.message ?? "nil")
    }
    
    func registrationFailure(error: ExceptionErrorHandle) {
        view?.showAlertFailure(message: error.error ?? "error message is nil")
    }
}
