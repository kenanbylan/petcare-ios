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
}

final class EmailVerificationPresenter {
    private weak var view: EmailVerificationViewProtocol?
    private let router: EmailVerificationRouterProtocol?
    private let interactor: EmailVerificationInteractorProtocol?
    var emailAddress: String?

    init(view: EmailVerificationViewProtocol?, router: EmailVerificationRouterProtocol?, interactor: EmailVerificationInteractorProtocol?, emailAddress: String?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.emailAddress = emailAddress
    }
}

extension EmailVerificationPresenter: EmailVerificationPresenterProtocol {
    func viewDidLoad() { }
    
    func navigateLogin() {
        router?.navigateToLogin()
    }
}

extension EmailVerificationPresenter: EmailVerificationInteractorOutput {
    func registrationSuccess(code: String) {
        print("Response Code: \(code)")
    }
    
    func registrationFailure(error: any Error) {
        print("error code \(error.localizedDescription)")
    }
}
