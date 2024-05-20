 //
//  ForgotPasswordPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.

import Foundation

protocol ForgotPasswordPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func backToLogin() -> Void
    func navigateToSenCode() -> Void
    func saveEmail(email: String) -> Void
    func requestCode()
}

final class ForgotPasswordPresenter {
    private weak var view: ForgotPasswordViewProtocol?
    private let router: ForgotPasswordRouterProtocol?
    private let interactor: ForgotPasswordInteractorProtocol?
    private var emailAddress: String?
    
    init(view: ForgotPasswordViewProtocol?, router: ForgotPasswordRouterProtocol?, interactor: ForgotPasswordInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    func viewDidLoad() { }
    
    func navigateMain() { }
    
    func saveEmail(email: String) {
        emailAddress = email
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
    
    func requestCode() {
        guard let email = emailAddress else { return }
        interactor?.forgotpassword(email: email)
    }
    
    func navigateToSenCode() {
        guard let email = emailAddress else { return }
        router?.navigateToSendCode(email:email)
    }
    
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutput {
    func registrationSuccess(code: String) {
        print("Response Code: \(code)")
        view?.showAlertStatus(message: code)
    }
    
    func registrationFailure(error: ExceptionErrorHandle) {
        guard let error = error.error else { return }
        view?.showAlertStatus(message: error )
    }
}
