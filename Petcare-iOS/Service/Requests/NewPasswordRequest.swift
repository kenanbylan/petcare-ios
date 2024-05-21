//
//  NewPasswordRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 1.05.2024.
//

import Foundation

struct NewPasswordRequest: DataRequest {
    typealias Response = NewPasswordResponse
    typealias ResponseError = ExceptionErrorHandle
    
    let email: String
    let password: String
    
    var url: String {
        let baseURL = APIConfig(environment: .development).baseURL()
        return "\(baseURL)auth/reset-password"
    }
    
    var method: HTTPMethod = .post
    
    var body: Data? {
        let bodyDict = ["email": email, "password": password]
        
        do {
            return try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        } catch {
            return nil
        }
    }
}


struct NewPasswordResponse: Codable {
    let message: String?
}

