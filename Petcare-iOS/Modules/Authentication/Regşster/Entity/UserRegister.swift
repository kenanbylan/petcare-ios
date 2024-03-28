//
//  UserSignUp.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.11.2023.
//

import Foundation

struct UserRegisterRequest: Codable {
    var name: String?
    var surname: String?
    var email: String?
    var password: String?
    
    enum CodingKeys: CodingKey {
        case name
        case surname
        case email
        case password
    }
    
}

