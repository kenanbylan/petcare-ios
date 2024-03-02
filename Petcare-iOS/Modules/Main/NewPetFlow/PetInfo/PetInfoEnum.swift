//
//  PetInfoEnum.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import Foundation

enum NameState: Equatable {
    case idle
    case error(ErrorState)
    case success
    
    enum ErrorState {
        case empty
        case toShort
        case numbers
        case specialChars
        
        var description: String {
            switch self {
            case .empty:
                return "Field can't be empty."
            case .toShort:
                return "Name is to short."
            case .numbers:
                return "Name can't contain any numbers."
            case .specialChars:
                return "Name can't contain special characters."
            }
        }
    }
}
