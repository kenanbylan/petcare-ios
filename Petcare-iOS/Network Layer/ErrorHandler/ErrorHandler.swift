//
//  ErrorHandler.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidParameters
    case invalidResponse
    case noToken
    case serverError(message: String)
    case decodingError
}

struct ErrorHandler {
    static func handle(_ error: Error) {
        
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidURL:
                print("Invalid URL")
                // Uygulama içinde görsel bir hata mesajı gösterebilirsiniz
            case .invalidParameters:
                print("Invalid Parameters")
                // Uygulama içinde görsel bir hata mesajı gösterebilirsiniz
            case .noToken:
                print("No Token")
                // Kullanıcıya oturumunun sonlandırıldığına dair bir bildirim gösterebilirsiniz
            case .serverError(let message):
                print("Server Error: \(message)")
                // Sunucudan gelen özel bir hata mesajını gösterebilirsiniz
            case .decodingError:
                print("Decoding Error")
                // JSON çözme hatası durumunda uygun bir işlem yapabilirsiniz
            case .invalidResponse:
                print("invalidResponse Error")
            }
        } else {
            // Diğer hata türleri için genel bir hata mesajı gösterebilirsiniz
            print("An error occurred: \(error.localizedDescription)")
        }
    }
}
