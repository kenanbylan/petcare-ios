//
//  PersonInfo.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.05.2024.

import Foundation

struct PersonRequest: DataRequest {
    typealias Response = PersonData
    typealias ResponseError = ExceptionErrorHandle
    
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "users?userId=\(TokenManager.shared.userId)"
    }
    
    var method: HTTPMethod = .get
    
    var headers: [String: String]? {
        if let token = TokenManager.shared.accessToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
}


struct PersonData: Codable {
    let information: [PersonResponse]
}
