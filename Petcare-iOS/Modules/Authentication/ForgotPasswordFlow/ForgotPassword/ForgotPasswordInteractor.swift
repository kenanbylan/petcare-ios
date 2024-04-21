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
    func registrationFailure(error: Error)
}

final class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    var output: ForgotPasswordInteractorOutput?
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func forgotpassword(email: String)  {
        //will be added forgot password
        
    }
}
