//
//  RegisterInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation

protocol RegisterInteractorProtocol {
    func registerUser(registerUser: UserRegisterRequest) -> Void
}

protocol RegisterInteractorOutput {
    func registrationSuccess(response: UserRegisterResponse)
    func registrationFailure(error: ExceptionErrorHandle)
}

final class RegisterInteractor : RegisterInteractorProtocol {
    var output: RegisterInteractorOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func registerUser(registerUser: UserRegisterRequest) {
        let registerRequest = RegisterRequest(role: registerUser.role!.rawValue,
                                              name: registerUser.name!,
                                              surname: registerUser.surname!,
                                              email: registerUser.email!,
                                              password: registerUser.password!)
        
        networkService.request(registerRequest) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                print("Register interactor: \(response)")
                self?.output?.registrationSuccess(response: response)
            case .failure(let error):
                self?.output?.registrationFailure(error: error)
            }
        }
    }
}
