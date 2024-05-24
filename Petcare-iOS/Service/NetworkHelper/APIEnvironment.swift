//
//  APIEnvironment.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//
import Foundation

///https://jsonplaceholder.org/users/1
///http://192.168.1.7:8080/api/v1

enum APIEnvironment {
    case development
    case test
    case production
    
    func baseURL() -> String {
        switch self {
        case .development:
            return "http://localhost:8082"
        case .test:
            return "https://jsonplaceholder.org"
        case .production:
            return "http://192.168.1.7:8080"
        }
    }
    
    func route() -> String {
        switch self {
        case .development:
            return "/api/v1/"
        case .test:
            return "/users/1"
        case .production:
            return "/api/v1"
        }
    }
}
