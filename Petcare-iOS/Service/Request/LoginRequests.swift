//
//  LoginRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.
//

import Foundation


struct LoginRequests: DataRequest {
    typealias Response = LoginResponse // Yanıtın türü LoginResponse olacak
    
    let url: String = "https://jsonplaceholder.typicode.com/posts"
    let method: HTTPMethod = .get
    let loginData: LoginRequest
    
    // Giriş bilgilerini JSON formatına dönüştürmek için encode() metodu
    func encode() throws -> Data? {
        return try JSONEncoder().encode(loginData)
    }
    
    
}
