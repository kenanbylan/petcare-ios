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
        }
    }
}
