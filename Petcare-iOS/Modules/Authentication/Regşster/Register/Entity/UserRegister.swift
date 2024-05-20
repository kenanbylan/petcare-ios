//
//  UserSignUp.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.11.2023.

import Foundation

enum ROLE: String {
    case USER
    case VETERINARY
}

struct UserRegisterRequest {
    var name, surname, email, password: String?
    var role: ROLE?
    var address: VetAddress?
    var document: Document?
}

// MARK: - Address
struct VetAddress: Codable {
    let phoneNumber, clinicName, clinicCity, clinicDistrict: String?
    let clinicStreet, clinicNo, apartmentNo: String?
}

// MARK: - Document
struct Document: Codable {
    let base64Document: String?
}

enum VetDocumentStatus {
    case APPROVED
    case PENDING
    case REJECTED
}
