//
//  PersonResponse.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 20.05.2024.
//

import Foundation

struct PersonResponse: Codable {
    let id: String?
    let createdAt: String?
    let updatedAt: String?
    let name: String?
    let surname: String?
    let email: String?
    let role: String?
}
