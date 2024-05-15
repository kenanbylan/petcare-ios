//
//  EmaiVerificationRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.04.2024.
//

import Foundation

///http://localhost:8081/api/v1/auth/activate-account?token=597459a

struct EmailVerificationRequest: DataRequest {
    typealias ResponseError = ExceptionErrorHandle
    typealias Response = EmailVerificationResponse
    
    let sendCode: String
    let resetPassword: Bool
    
    var url: String {
        let baseURL = APIConfig(environment: .development).baseURL()
        if resetPassword {
            return "\(baseURL)auth/isPasswordResetTokenValid"
        }
        return "\(baseURL)auth/activate-account"
    }
    
    var method: HTTPMethod = .get
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [String: String] {
        return ["token": sendCode]
    }
}

struct EmailVerificationResponse: Codable {
    let message: String
}
