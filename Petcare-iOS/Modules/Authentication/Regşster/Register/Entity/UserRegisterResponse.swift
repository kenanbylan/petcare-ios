//
//  UserRegisterResponse.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 27.02.2024.
//

import Foundation

struct RegisterRequest: DataRequest {
    typealias ResponseError = ExceptionErrorHandle
    typealias Response = UserRegisterResponse
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "auth/register"
    }
    
    var method: HTTPMethod = .post

    var role: ROLE.RawValue
    var name: String
    var surname: String
    var email: String
    var password: String
    
    var body: Data? {
        let bodyDict = ["role": role,
                        "name": name,
                        "surname": surname,
                        "email": email,
                        "password": password]
        
        do {
            return try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        } catch {
            return nil
        }
    }
}

struct UserRegisterResponse: Codable {
    let message: String?
}
