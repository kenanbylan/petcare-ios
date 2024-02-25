//
//  TokenManager.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.02.2024.
//

import Foundation

final class TokenManager {
    static let shared = TokenManager()
    
    private let userDefaults = UserDefaults.standard
    private let tokenKey = "UserToken"
    private let expirationKey = "TokenExpiration"
    
    var token: String? {
        get {
            return userDefaults.string(forKey: tokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: tokenKey)
        }
    }
    
    var expirationDate: Date? {
        get {
            return userDefaults.object(forKey: expirationKey) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: expirationKey)
        }
    }
    
    func clearToken() {
        userDefaults.removeObject(forKey: tokenKey)
        userDefaults.removeObject(forKey: expirationKey)
    }
    
    func updateToken(token: String, expirationDate: Date) {
        self.token = token
        self.expirationDate = expirationDate
    }
    
    
    func isTokenValid() -> Bool {
        guard let expirationDate = expirationDate else {
            return false
        }
        return expirationDate > Date() // Kontrol tokenin geçerlilik süresini
    }
    
    
    private init() {
        if let expirationDate = expirationDate, expirationDate < Date() {
            clearToken()
        }
    }
}
