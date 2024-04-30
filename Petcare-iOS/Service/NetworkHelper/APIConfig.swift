//
//  APIConfig.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation

struct APIConfig {
    let environment: APIEnvironment
    
    func baseURL() -> String {
        return "\(environment.baseURL())\(environment.route())"
    }
}

/// MARK: print(config.baseURL()) //Output: http://localhost:8080/api/v1
