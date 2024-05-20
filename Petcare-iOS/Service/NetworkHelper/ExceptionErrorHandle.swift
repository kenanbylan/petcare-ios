//
//  ErrorResponse.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.

import Foundation

struct ExceptionErrorHandle: Codable, Error {
    var ebusinessCode: String?
    var businessErrorDetails: String?
    var error: String?
    
    init(ebusinessCode: String?, businessErrorDetails: String?, error: String?) {
        self.ebusinessCode = ebusinessCode
        self.businessErrorDetails = businessErrorDetails
        self.error = error
    }
}
