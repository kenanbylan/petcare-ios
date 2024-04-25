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
    func navigateToSmsOtp() -> Void
}

final class ForgotPasswordPresenter {
    private weak var view: ForgotPasswordViewProtocol?
    private let router: ForgotPasswordRouterProtocol?
    private let interactor: ForgotPasswordInteractorProtocol?
    
    init(view: ForgotPasswordViewProtocol?, router: ForgotPasswordRouterProtocol?, interactor: ForgotPasswordInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    func viewDidLoad() { }
    
    func navigateMain() { }
    
    func backToLogin() {
        router?.backToLogin()
    }
    
    func navigateToSmsOtp() {
        router?.navigateToSendCode()
    }
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutput {
    func registrationSuccess(code: String) {
        print("Response Code: \(code)")
    }
    
    func registrationFailure(error: any Error) {
        print("error code \(error.localizedDescription)")
    }
}
