//
//  SavePetEntity.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.05.2024.
//

import Foundation

///  {{api_url}}:{{api_port}}/api/v1/pets?userId=bb19ab35-450b-4075-b4f5-5b2e7ce20dae

struct SavePetRequest: DataRequest {
    typealias Response = PetResponse
    typealias ResponseError = ExceptionErrorHandle
    
    var userId: String?
    
    var name: String?
    var type: String?
    var gender: String?
    var image: String?
    var specialInfo: String?
    var height: Double?
    var weight: Double?
    var birthDate: String?
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "pets?userId=\(TokenManager.shared.userId!)"
    }
    
    var method: HTTPMethod = .post
    
    var headers: [String : String]? {
        if let token = TokenManager.shared.accessToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
    
    var queryItems: [String: String] {
        return ["userId": TokenManager.shared.userId!]
    }
    
    var body: Data? {
        let parameters: [String: Any] = [
            "name": name ?? "",
            "type": type ?? "Unknown",
            "gender": gender ?? "Unknown GENDER",
            "image": image ?? "",
            "specialInfo": specialInfo ?? "",
            "height": height ?? "",
            "weight": weight ?? "",
            "birthDate": birthDate ?? ""
        ]
        
        do {
            print("SavePetRequest Body \(parameters) ")
            return try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error encoding parameters: \(error)")

            return nil
        }
    }
}

struct PetResponse: Codable {
    let id: String?
    let createdAt: String?
    let updatedAt: String?
    let name: String?
    let type: String?
    let gender: String?
    let image: String?
    let specialInfo: String?
    let weight: Double?
    let height: Double?
    let longitude: Double?
    let latitude: Double?
    let birthDate: String?
}
