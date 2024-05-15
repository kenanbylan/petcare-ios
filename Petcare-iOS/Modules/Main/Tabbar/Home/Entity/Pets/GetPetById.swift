//
//  GetPetById.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.05.2024.
//

import Foundation

struct GetPetById: DataRequest {
    typealias Response = PetResponse
    typealias ResponseError = ExceptionErrorHandle
    
    var petId: String?
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "pets/\(petId ?? "nil")"
    }
    
    var method: HTTPMethod = .get
    
    var headers: [String : String]? {
        if let token = TokenManager.shared.accessToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
}
