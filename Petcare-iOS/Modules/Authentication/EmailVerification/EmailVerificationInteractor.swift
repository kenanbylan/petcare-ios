//
//  EmailVerificationInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation

protocol EmailVerificationInteractorProtocol {
    func codeVerification(code: String, resetPassword: Bool?) -> Void
    
}

protocol EmailVerificationInteractorOutput {
    func registrationSuccess(message: EmailVerificationResponse)
    func registrationFailure(error: ExceptionErrorHandle)
}

final class EmailVerificationInteractor: EmailVerificationInteractorProtocol {
    var output: EmailVerificationInteractorOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func codeVerification(code: String, resetPassword: Bool?) -> Void {
        let request = EmailVerificationRequest(sendCode: code, resetPassword: resetPassword ?? false)
        networkService.request(request) { response in
            switch response {
            case .success(let res):
                self.output?.registrationSuccess(message: res)
            case .failure(let error):
                print("Error Email Verify: \(error)")
                self.output?.registrationFailure(error: error)
            }
        }
    }
}
