//
//  SmsOtpPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.02.2024.
//

import Foundation


protocol CodeVerificationPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func backToLogin() -> Void
}

final class CodeVerificationPresenter {
    private weak var view: CodeVerificationViewProtocol?
    private let router: CodeVerificationRouterProtocol?
    private let interactor: CodeVerificationInteractorProtocol?
    
    init(view: CodeVerificationViewProtocol?, router: CodeVerificationRouterProtocol?, interactor: CodeVerificationInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension CodeVerificationPresenter: CodeVerificationPresenterProtocol {
    func viewDidLoad() { }
    
    func navigateMain() { }
    
    func backToLogin() {
        router?.backToLogin()
    }
    
}

extension CodeVerificationPresenter: CodeVerificationInteractorOutput {
    func registrationSuccess(code: String) {
        print("Response Code: \(code)")
    }
    
    func registrationFailure(error: any Error) {
        print("error code \(error.localizedDescription)")
    }
}
