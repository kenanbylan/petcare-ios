//
//  URLrOUTER.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 24.02.2024.
//

import Foundation

enum URLRouter {
    case podcast
    case login
    case register
    case jsonfake
    case new_pet
    case users
    //http:1230912:/v1/api/users
    
    var path: String {
        switch self {
        case .podcast:
            return "podcast.json"
        case .login:
            return "login"
        case .register:
            return "register"
        case .jsonfake:
            return "todos"
        case .new_pet:
            return "new_pati"
        case .users:
            return "users"
        }
    }
}
