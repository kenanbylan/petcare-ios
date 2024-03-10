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
    func navigateMain() -> Void
    func navigateSignUp() -> Void
    func navigateForgotPassword() -> Void
    func controlGoogleWithSignIn(myself: UIViewController)
}

final class LoginPresenter: ObservableObject {
    private weak var view: LoginViewProtocol?
    let router: LoginRouterProtocol?
    let interactor: LoginInteractorProtocol?
    
    init(view: LoginViewProtocol? , router: LoginRouterProtocol?, interactor: LoginInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func viewDidload() {
        
    }
    
    func navigateMain() {
        router?.navigateToMain()
    }
    
    func navigateSignUp() {
        router?.navigateToSignUp()
    }
    
    func navigateForgotPassword() {
        router?.navigateToForgotPassword()
    }
    
    func controlGoogleWithSignIn(myself: UIViewController) {
    }
    
}

extension LoginPresenter: LoginInteractorOutput {
    func registrationSuccess() {
            
    }
    
    func registrationFailure(error: Error) {
            
    }
    

}
