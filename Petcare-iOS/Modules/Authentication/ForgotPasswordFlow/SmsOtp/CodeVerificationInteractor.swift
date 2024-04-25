//
//  SmsOtpInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.02.2024.
//


import Foundation

protocol CodeVerificationInteractorProtocol { }

protocol CodeVerificationInteractorOutput {
    func registrationSuccess(code: String)
    func registrationFailure(error: Error)
}

final class CodeVerificationInteractor: CodeVerificationInteractorProtocol {
    var output: CodeVerificationInteractorOutput?
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}
