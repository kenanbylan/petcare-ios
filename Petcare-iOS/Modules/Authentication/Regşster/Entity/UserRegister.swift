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
    var role: ROLE
    var name: String
    var surname: String
    var email: String
    var password: String
    
    var vetInfo: VetAddress?
    var document: VetDocument?
    
    init(role: ROLE, name: String, surname: String, email: String, password: String, vetInfo: VetAddress? = nil, document: VetDocument? = nil) {
        self.role = role
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.vetInfo = vetInfo
        self.document = document
    }
}

struct VetAddress {
    var clinicName: String?
    var clinicCity: String?
    var phone: String?
    var clinicDiscrict: String?
    var clinicStreet: String?
    var clinicNo: String?
    var apartmentNo: String?
}

struct VetDocument {
    var document: Data?
    var status: VetDocumentStatus? = .PENDING
}

enum VetDocumentStatus {
    case APPROVED
    case PENDING
    case REJECTED
}
