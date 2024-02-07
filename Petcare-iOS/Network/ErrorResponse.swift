//
//  File.swift
//  
//
//  Created by Kenan Baylan on 10.12.2023.
//

import Foundation

enum APIError: Error {
    case invalidEndpoint
    case invalidURL
    case unableToSetHeaders
    case requestFailed(String)
    case decodingError
    case networkError(Error)
}

//enum APIError: Error {
//    case apiError
//    case invalidEndpoint
//    case invalidRespons
//    case noData
//    case serializationError
//    case requestFailed(String)
//}
//
//enum ErrorResponse {
//    
//    case apiError
//    case invalidEndpoint
//    case invalidResponse
//    case noData
//    case serializationError
//    
//    public var description: String {
//        switch self {
//        case .apiError: return "There is something problem with the API"
//        case .invalidEndpoint: return "There is something problem with the Endpoint"
//        case .invalidResponse: return "There is something problem with the Response Model"
//        case .noData: return "Something problem with the Data"
//        case .serializationError: return "Problem with the Serialization Process"
//        }
//    }
//}

//MARK:JSON verilerini çözümleme işlemi sırasında ortaya çıkan hatalar DecodingError tipi altında bulunabilir ve bu hatalar genellikle "serializationError" olarak adlandırılır.
