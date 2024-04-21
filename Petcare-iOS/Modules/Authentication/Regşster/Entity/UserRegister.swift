//
//  UserSignUp.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.11.2023.

import Foundation

enum ROLE {
    case USER
    case VETERINARY
}

struct UserRegisterRequest {
    var role: ROLE
    var name: String
    var surname: String
    var email: String
    var password: String
    
    var vetInfo: VetInformation?
    var document: VetDocument?
}

struct VetInformation {
    var address: VetAddress
    var phone: VetPhone
}

struct VetAddress {
    var clinicName: String?
    var clinicCity: String?
    var clinicDiscrict: String?
    var clinicStreet: String?
    var clinicNo: String?
    var apartmentNo: String?
}

struct VetPhone {
    var phone: String
}

struct VetDocument {
    var document: String?
    var status: VetDocumentStatus?
}

enum VetDocumentStatus {
    case APPROVED
    case PENDING
    case REJECTED
}

