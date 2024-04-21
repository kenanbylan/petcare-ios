//
//  EmailVerificationInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation

protocol EmailVerificationInteractorProtocol {
    func codeVerification(email: String) -> Void
    
}

protocol EmailVerificationInteractorOutput {
    func registrationSuccess(code: String)
    func registrationFailure(error: Error)
}

final class EmailVerificationInteractor: EmailVerificationInteractorProtocol {
    var output: EmailVerificationInteractorOutput?
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func codeVerification(email: String) -> Void {
        
    }
}
