//
//  VeterinaryResponse.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 22.05.2024.
//

import Foundation


struct VeterinaryResponse: Codable {
    let veterinaryId: String
    let createdAt: String
    let updatedAt: String
    let name: String
    let surname: String
    let email: String
    let role: String
    let address: Address?
    let document: DocumentVet?
}

// MARK: - Address
struct Address: Codable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let phoneNumber: String
    let clinicName: String
    let clinicCity: String
    let clinicDistrict: String
    let clinicStreet: String
    let clinicNo: String
    let apartmentNo: String
}


// MARK: - Document
struct DocumentVet: Codable {
    let id: Int
    let base64Document: String?
}

