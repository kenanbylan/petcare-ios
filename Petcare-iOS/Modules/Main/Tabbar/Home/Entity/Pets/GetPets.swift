//
//  GetPets.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.05.2024.
//

import Foundation

struct GetPets: DataRequest {
    typealias Response = GetPetsResponse
    typealias ResponseError = ExceptionErrorHandle
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "users/getPets/\(TokenManager.shared.userId!)"
    }
    
    var method: HTTPMethod = .get
    
    var headers: [String : String]? {
        if let token = TokenManager.shared.accessToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
}

struct GetPetsResponse: Codable {
    let pets: [PetResponse]
}
