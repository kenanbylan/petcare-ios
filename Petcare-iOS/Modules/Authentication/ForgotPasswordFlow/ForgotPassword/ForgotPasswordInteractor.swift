//
//  ForgotPasswordInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import Foundation

protocol ForgotPasswordInteractorProtocol {
    func checkPassword( password: String) -> Void
}

protocol ForgotPasswordInteractorOutput {
    
}


final class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    var output: ForgotPasswordInteractorOutput?
    
    func checkPassword( password: String) {
        
    }
    
}

