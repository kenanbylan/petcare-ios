//
//  File.swift
//
//
//  Created by Kenan Baylan on 27.01.2024.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    var baseURL: String {
        switch self {
            
        case .development:
            return "development.example.com"
        case .staging:
            return "staging.example.com"
        case .production:
            return "production.example.com"
        }
    }
}


//let endPoint: Endpoint = Endpoint.signIn
//print(endPoint.path) // prints "/api/postOne"
//print(endPoint.httpMethod) // .post
