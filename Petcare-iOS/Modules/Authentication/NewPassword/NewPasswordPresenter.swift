//
//  NewPasswordPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.02.2024.
//
import Foundation

protocol NewPasswordPresenterProtocol {
    func navigateToLogin() -> Void
    func fetchRequest() -> Void
    func saveNewPassword(password: String) -> Void
}

final class NewPasswordPresenter {
    private weak var view: NewPasswordViewProtocol?
    let router: NewPasswordRouterProtocol?
    let interactor: NewPasswordInteractorProtocol?
    
    var existEmail: String
    var newPassword: String?
    
    init(view: NewPasswordViewProtocol?, router: NewPasswordRouterProtocol?, interactor: NewPasswordInteractorProtocol?,existEmail: String) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.existEmail = existEmail
    }
}

extension NewPasswordPresenter: NewPasswordPresenterProtocol {
    
    func saveNewPassword(password: String) {
        newPassword = password
    }
    
    func fetchRequest() {
        guard let newPassword = newPassword else { return }
        interactor?.resetPasswordCode(email: existEmail, password: newPassword)
    }
    
    func navigateToLogin() {
        router?.navigateToLogin()
    }
}


extension NewPasswordPresenter: NewPasswordInteractorOutputProtocol {
    func newPasswordSuccess(response: NewPasswordResponse) {
        view?.showAlertMessage(message: response.message ?? "test")
    }
    
    func newPasswordFailure(error: ExceptionErrorHandle) {
        view?.showAlertFailure(message: error.localizedDescription)
    }
}
