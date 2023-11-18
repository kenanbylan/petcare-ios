//
//  RegisterInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation

protocol RegisterInteractorProtocol {
    func getSignUpData() -> Void
}

protocol RegisterInteractorOutput {
    func internetConnectionStatus(_ status: Bool)
}


final class RegisterInteractor : RegisterInteractorProtocol {
    var output: RegisterInteractorOutput?
    
    func getSignUpData() {
        
    }
}
