//  LoginPresenter.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 14.10.2023.

import Foundation
import UIKit

protocol LoginPresenterProtocol {
    func navigateMain() -> Void
    func navigateSignUp() -> Void
    func navigateForgotPassword() -> Void
    func navigateToVeterinaryMain() -> Void
    func saveUser(_ user: LoginRequest)
    func fetchLogin() -> Void
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
    func fetchLogin() {
        interactor?.login(user: userData!)
    }
    
    func saveUser(_ user: LoginRequest) {
        userData = user
    }
    
    //MARK: - Router's
    func navigateMain() {
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
        guard let jwtToken = user.token else { return }
        do {
            let decodedPayload = try JWTDecoder().decode(jwtToken: jwtToken)
            guard let email = decodedPayload["sub"] as? String,
                  let userId = decodedPayload["user_id"] as? String,
                  let userRole = decodedPayload["user_role"] as? String,
                  let expirationTimestamp = decodedPayload["exp"] as? TimeInterval else {
                return
            }
            
            let refreshToken = user.refreshToken ?? ""
            TokenManager.shared.updateTokens(accessToken: jwtToken, refreshToken: refreshToken, accessTokenExpirationDate: Date(timeIntervalSince1970: expirationTimestamp), refreshTokenExpirationDate: Date(), userId: userId, email: email, userRole: userRole)
            
            if let role = ROLE(rawValue: userRole) {
                switch role {
                case .USER:
                    router?.navigateToMain()
                case .VETERINARY:
                    router?.navigateToVeterinaryMain()
                }
            } else {
                //MARK: - burada backendden hesabın enable veya dissable olduğu durumuda gelmelidir. Bu işleme göre kullanıcıya farklı bir message gönderilecektir.
                view?.showAlertMessage(message: "ROLE Alınamadı.")
            }
        } catch {
            print("Hata oluştu: \(error)")
        }
    }
    
    func registrationFailure(error: ExceptionErrorHandle) {
        view?.showAlertMessage(message: error.error ?? "error message is nil")
    }
    
    private func decodingTokenMethodGetRole(jwtToken: String) -> ROLE?  {
        do {
            let decodedPayload = try TokenManager.shared.decodeJWT(jwtToken)

            print("DECODED PAYLOAD : \(decodedPayload)")

            if let userRoleString = decodedPayload["user_role"] as? String,
               let userRole = ROLE(rawValue: userRoleString) {
                return userRole
            } else {
                return nil
            }
        } catch {
            print("DECODED PAYLOAD ERROR: \(error)")
            return nil
        }
    }
}
