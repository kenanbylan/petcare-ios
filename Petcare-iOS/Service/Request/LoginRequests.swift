//
//  LoginRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.

import Foundation

struct LoginRequests: DataRequest {
    typealias Response = LoginResponse
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "auth/authenticate"  // Login endpointi eklendi
    }
    
    let method: HTTPMethod = .post
    let email: String
    let password: String
    
    //    let parameters = ["email": email, "password": password]
    //
    //    // Sözlüğü JSON verisine dönüştürme
    //    guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
    //        print("Error creating JSON data")
    //        return
    //    }
    
    
    var body: Data? {
        let parameters = ["email": email, "password": password]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error creating JSON data")
            return Data()
        }
        return jsonData
    }
    
    //    var body: Data? {
    //        let json: [String: Any] = ["email": email, "password": password]
    //
    //        do {
    //            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
    //            print("JSON DATA: \(jsonData)")
    //            return jsonData
    //        } catch {
    //            print("Error creating JSON data: \(error)")
    //            return nil
    //        }
    //    }
    
    
    func decode(_ data: Data) throws -> LoginResponse {
        let decoder = JSONDecoder()
        let result = try decoder.decode(LoginResponse.self, from: data)
        print("RESULT DECODE DATA  \(result)")
        return result
        
    }
}
