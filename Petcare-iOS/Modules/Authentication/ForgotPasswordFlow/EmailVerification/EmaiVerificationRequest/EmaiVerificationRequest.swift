//
//  EmaiVerificationRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.04.2024.
//

import Foundation

///http://localhost:8081/api/v1/auth/activate-account?token=597459a
struct EmaiVerificationRequest: DataRequest {
    typealias Response = EmailVerificationResponse
    let verifyCode: String
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "auth/activate-account?token=\(verifyCode)"
    }
    
    var method: HTTPMethod = .get
    
    var headers: [String: String]? {
        return ["application/json": "Content-Type"]
    }
}

struct EmailVerificationResponse: Codable {
    //let status: Int
}
