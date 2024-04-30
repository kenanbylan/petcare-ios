//
//  EmaiVerificationRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.04.2024.
//

import Foundation

///http://localhost:8081/api/v1/auth/activate-account?token=597459a

struct EmailVerificationRequest: DataRequest {
    typealias Response = EmailVerificationResponse
    let verifyCode: String
    
    var url: String {
        let baseURL = APIConfig(environment: .development).baseURL()
        let encodedVerifyCode = verifyCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return "\(baseURL)auth/activate-account?token=\(encodedVerifyCode)"
    }
    
    var method: HTTPMethod = .get
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

struct EmailVerificationResponse: Codable {
    let message: String
}
