//
//  ForgotPasswordEntity.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.

import Foundation

struct ForgotPasswordRequest: DataRequest {
    typealias ResponseError = ExceptionErrorHandle
    typealias Response = ForgotPasswordResponse
    
    var url: String {
        let baseURL = APIConfig(environment: .development).baseURL()
        return "\(baseURL)auth/sendResetPasswordEmail"
    }
    
    let method: HTTPMethod = .post
    
    let email: String
    
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [String: String] {
        return ["email": email]
    }
}
