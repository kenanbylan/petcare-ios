//
//  NewPasswordInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.02.2024.
//

import Foundation
import UIKit

protocol NewPasswordInteractorProtocol: AnyObject{
    func resetPasswordCode(email: String, password: String) -> Void
}

protocol NewPasswordInteractorOutputProtocol {
    func newPasswordSuccess(response: NewPasswordResponse)
    func newPasswordFailure(error: ExceptionErrorHandle)
}

final class NewPasswordInteractor: NewPasswordInteractorProtocol {
    var output: NewPasswordInteractorOutputProtocol?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func resetPasswordCode(email: String, password: String) {
        let request = NewPasswordRequest(email: email, password: password)
        
        networkService.request(request) { result in
            switch result {
            case .success(let res):
                self.output?.newPasswordSuccess(response: res)
            case .failure(let error):
                self.output?.newPasswordFailure(error: error)
            }
        }
    }
}
