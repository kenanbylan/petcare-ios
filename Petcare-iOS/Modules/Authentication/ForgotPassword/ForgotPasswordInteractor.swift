//
//  ForgotPasswordInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import Foundation

protocol ForgotPasswordInteractorProtocol {
    func forgotpassword(email: String) -> Void
}

protocol ForgotPasswordInteractorOutput {
    func registrationSuccess(code: String)
    func registrationFailure(error: ExceptionErrorHandle)
}

final class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    var output: ForgotPasswordInteractorOutput?
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func forgotpassword(email: String)  {
        let request = ForgotPasswordDTO(email: email)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let res):
                self?.output?.registrationSuccess(code: res.message)
            case .failure(let error):
                self?.output?.registrationFailure(error: error)
            }
        }
    }
}
