//
//  LoginInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation


protocol LoginInteractorProtocol {
    func checkUserLogin(email: String, password: String)
}

protocol LoginInteractorOutput {
    func internetConnectionStatus(_ status: Bool)
}


final class LoginInteractor : LoginInteractorProtocol {
    var output: LoginInteractorOutput?
    
    func checkUserLogin(email: String, password: String) {
        
    }
    
}

