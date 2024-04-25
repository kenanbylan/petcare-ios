//
//  LoginInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import Combine

protocol LoginInteractorProtocol {
    func login(user: LoginRequest) -> Void
}

protocol LoginInteractorOutput {
    func registrationSuccess(user: LoginResponse)
    func registrationFailure(error: ExceptionErrorHandle)
}

final class LoginInteractor: LoginInteractorProtocol, ObservableObject {
    
    var output: LoginInteractorOutput?
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func login(user: LoginRequest) {
        let loginRequest = LoginRequests(email: user.email ?? "", password: user.password ?? "")
        
        networkService.request(loginRequest) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                print("loginUser: \(response)")
                //self.output?.registrationSuccess(user: response)
            case .failure(let error): 
                print("Interactor Error \(error.error)")
                self?.output?.registrationFailure(error: error)
            }
        }
    }
}
