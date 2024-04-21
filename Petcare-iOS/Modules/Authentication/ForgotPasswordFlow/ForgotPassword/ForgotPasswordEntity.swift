//
//  ForgotPasswordEntity.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation

struct ForgotPasswordRequest: Codable {
    var email: String
}

struct ForgotPasswordResponse: Codable {
    var code: String
    
}


struct ForgotPasswordDTO: DataRequest {
    typealias Response = ForgotPasswordResponse

    var url: String = APIConfig(environment: .development).baseURL() + "/forgotpassword"
    let method: HTTPMethod = .post
    var contentType: String? { "application/json" } // Content-Type belirtildi

    let forgotPasswordData: ForgotPasswordRequest
    
    
    // Giriş bilgilerini JSON formatına dönüştürmek için encode() metodu
    func encode() throws -> Data? {
        let credentials = ["email": forgotPasswordData.email]
        return try JSONSerialization.data(withJSONObject: credentials, options: [])
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var queryItems: [String : String] {
        return [:]
    }
    
    func decode(_ data: Data) throws -> ForgotPasswordResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(ForgotPasswordResponse.self, from: data)
    }
}
