//
//  File.swift
//
//
//  Created by Kenan Baylan on 27.01.2024.
//

import Foundation

enum Endpoint {
    case signIn
    case signUp
    case forgotPassword
    case resertPassword
    case myPets
    case reminder
    case calendar
    
    var path: String {
        switch self {
            
        case .signIn:
            return "https://jsonplaceholder.typicode.com/todos/1"
        case .signUp:
            return "example/api/signUp"
        case .forgotPassword:
            return "example/api/forgotPassword"
        case .resertPassword:
            return "example/api/resertPassword"
        case .myPets:
            return "example/api/myPets"
        case .reminder:
            return "example/api/reminder"
        case .calendar:
            return "example/api/calendar"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
            
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .forgotPassword:
            return .post
        case .resertPassword:
            return .post
        case .myPets:
            return .get
        case .reminder:
            return .get
        case .calendar:
            return .post
        }
    }
}
