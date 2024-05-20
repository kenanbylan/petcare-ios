//
//  User.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.

import Foundation

struct LoginRequest: Codable {
    var email: String?
    var password: String?
}

struct LoginResponse: Codable {
    var token: String?
    var refreshToken: String?
}
