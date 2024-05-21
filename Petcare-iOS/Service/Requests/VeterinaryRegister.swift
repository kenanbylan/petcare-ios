//
//  VeterinaryRegister.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.05.2024.
//

import Foundation

struct VeterinaryRegister: DataRequest {
    typealias Response = VetResponse
    typealias ResponseError = ExceptionErrorHandle
    
    var url: String {
        return APIConfig(environment: .development).baseURL() + "auth/register"
    }
    
    var method: HTTPMethod = .post
    
    var name: String
    var surname: String
    var email: String
    var password: String
    var role: String = "VETERINARY"
    var phoneNumber: String?
    var clinicName: String?
    var clinicCity: String?
    var clinicDistrict: String?
    var clinicStreet: String?
    var clinicNo: String?
    var apartmentNo: String?
    var base64Document: String?
    
    var body: Data? {
        let parameters: [String: Any] = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password,
            "role": role,
            "address": [
                "phoneNumber": phoneNumber,
                "clinicName": clinicName,
                "clinicCity": clinicCity,
                "clinicDistrict": clinicDistrict,
                "clinicStreet": clinicStreet,
                "clinicNo": clinicNo,
                "apartmentNo": apartmentNo
            ],
            "document": [
                "base64Document": base64Document
            ]
        ]
        
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: [])
            
        } catch {
            print("Error encoding parameters: \(error)")
            return nil
        }
    }
}

struct VetResponse: Codable {
    let message: String?
}
