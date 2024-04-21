//
//  RegisterInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation
import Combine

protocol RegisterInteractorProtocol {
    func registerUser(registerUser: UserRegisterRequest) -> Void
}

protocol RegisterInteractorOutput: AnyObject {
    func registrationSuccess()
    func registrationFailure(error: Error)
}

final class RegisterInteractor : RegisterInteractorProtocol {
    weak var output: RegisterInteractorOutput?
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func registerUser(registerUser: UserRegisterRequest) {
        
    }
}
