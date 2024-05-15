//
//  EmailVerificationPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation

protocol EmailVerificationPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateLogin() -> Void
    func resetPasswordCode() -> Void
    func setEmailAddress() -> String
    func saveCode(code: String) -> Void
}

final class EmailVerificationPresenter {
    private weak var view: EmailVerificationViewController?
    private let router: EmailVerificationRouterProtocol?
    private let interactor: EmailVerificationInteractorProtocol?
    
    var emailAddress: String?
    var verifyCode: String?
    var resetPassword: Bool?
    
    init(view: EmailVerificationViewController?, router: EmailVerificationRouterProtocol?, interactor: EmailVerificationInteractorProtocol?, emailAddress: String?, resetPassword: Bool? = nil ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.emailAddress = emailAddress
        self.resetPassword = resetPassword
    }
}

extension EmailVerificationPresenter: EmailVerificationPresenterProtocol {
    func setEmailAddress() -> String {
        guard let email = emailAddress else { return  "example.com" }
        return email
    }
    
    func saveCode(code: String) {
        verifyCode = code
    }
    
    func viewDidLoad() {
        interactor?.codeVerification(code: verifyCode ?? "test@gmail.com",resetPassword: resetPassword)
    }
    
    func navigateLogin() {
        router?.navigateToLogin()
    }
    
    func resetPasswordCode() {
        guard let email = emailAddress else { return }
        router?.navigateToResetPassword(email: email )
    }
}

extension EmailVerificationPresenter: EmailVerificationInteractorOutput {
    func registrationSuccess(message: EmailVerificationResponse) {
        print("Response Code: \(message.message)")
        self.view?.showSuccessAlert(message: message.message, resetPassword: resetPassword ?? false)
    }
    
    func registrationFailure(error: ExceptionErrorHandle) {
        guard let error = error.error else { return}
        self.view?.showErrorAlert(message: error )
    }
}
