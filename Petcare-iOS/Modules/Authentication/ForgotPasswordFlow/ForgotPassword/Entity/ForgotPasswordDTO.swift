//
//  ForgotPasswordDTO.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.04.2024.
//

import Foundation


struct ForgotPasswordRequest: Codable {
    var email: String
}

struct ForgotPasswordResponse: Codable {
    var message: String
}
