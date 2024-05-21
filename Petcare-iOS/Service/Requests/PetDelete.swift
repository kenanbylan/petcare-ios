//
//  PetDelete.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 20.05.2024.
//

import Foundation

//MARK: -pet delete methodu eklenecektir..

struct PetDeleteRequest: DataRequest {
    typealias Response = PetResponse
    typealias ResponseError = ExceptionErrorHandle
    
    var petId: String?
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "pets?"

    }
    
    var method: HTTPMethod = .get
}
