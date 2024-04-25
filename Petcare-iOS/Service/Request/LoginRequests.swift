//
//  LoginRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.

import Foundation

struct LoginRequests: DataRequest {
    typealias Response = LoginResponse // Response type
    
    let email: String
    let password: String
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "auth/authenticate"
    }
    
    let method: HTTPMethod = .post
    
    var headers: [String: String]? {
        return ["application/json": "Content-Type"]
    }
    
    var queryItems: [String: String] {
        return [:]
    }
    
    var body: Data? {
        let bodyDict = ["email": email, "password": password]
        do {
            return try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        } catch {
            return nil
        }
    }
}
