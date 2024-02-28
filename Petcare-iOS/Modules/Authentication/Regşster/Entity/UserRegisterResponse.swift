//
//  UserRegisterResponse.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 27.02.2024.
//

import Foundation

struct UserRegisterResponse: Decodable {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var name: String?
    var surname: String?
    var email: String?
    var role: String?
}
