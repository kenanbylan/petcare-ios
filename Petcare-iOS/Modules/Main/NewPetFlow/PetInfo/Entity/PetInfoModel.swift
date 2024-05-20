//
//  PetInfoModel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.04.2024.
//

import Foundation

enum Gender: Int {
    case MALE = 0
    case FEMALE
}

struct PetInfoModel {
    var gender: String?
    var type: String?
    var name: String
    var weight: String
    var height: String
    var birthDate: Date?
    var image: String?
    var specialInfo: String?
}

