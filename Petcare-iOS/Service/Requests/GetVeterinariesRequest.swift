//
//  GetVeterinariesRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 22.05.2024.
//

import Foundation

struct GetVeterinariesRequest: DataRequest {
    typealias Response = [VeterinaryResponse]
    typealias ResponseError = ExceptionErrorHandle
    
    var method: HTTPMethod = .get
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "petsveterinaries"
    }
    
    var headers: [String: String]? {
        if let token = TokenManager.shared.accessToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
    
}
