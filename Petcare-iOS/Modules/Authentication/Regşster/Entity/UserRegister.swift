//
//  UserSignUp.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.11.2023.
//

import Foundation

struct UserRegister: Codable {
    var firstName: String
    var lastname: String?
    var email: String
    var password: String
}

