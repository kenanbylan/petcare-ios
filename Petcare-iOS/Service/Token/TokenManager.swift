//
//  TokenManager.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.02.2024.
//

import Foundation

final class TokenManager {
    static let shared = TokenManager()
    private let jwtDecoder = JWTDecoder()
    
    private let userDefaults = UserDefaults.standard
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    private let userIdKey = "UserID"
    private let emailKey = "Email"
    private let userRoleKey = "UserRole"
    
    //MARK: DECODERS:
    func decodeJWT(_ jwtToken: String) throws -> [String: Any] {
        return try jwtDecoder.decode(jwtToken: jwtToken)
    }
    
    var accessToken: String? {
        get {
            return userDefaults.string(forKey: accessTokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: accessTokenKey)
        }
    }
    
    var refreshToken: String? {
        get {
            return userDefaults.string(forKey: refreshTokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: refreshTokenKey)
        }
    }
    
    var userId: String? {
        get {
            return userDefaults.string(forKey: userIdKey)
        }
        set {
            userDefaults.set(newValue, forKey: userIdKey)
        }
    }
    
    var email: String? {
        get {
            return userDefaults.string(forKey: emailKey)
        }
        set {
            userDefaults.set(newValue, forKey: emailKey)
        }
    }
    
    var userRole: String? {
        get {
            return userDefaults.string(forKey: userRoleKey)
        }
        set {
            userDefaults.set(newValue, forKey: userRoleKey)
        }
    }
    
    func clearTokens() {
        userDefaults.removeObject(forKey: accessTokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)
        userDefaults.removeObject(forKey: userIdKey)
        userDefaults.removeObject(forKey: emailKey)
        userDefaults.removeObject(forKey: userRoleKey)
    }
    
    func updateTokens(accessToken: String, refreshToken: String, accessTokenExpirationDate: Date, refreshTokenExpirationDate: Date, userId: String, email: String, userRole: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.userId = userId
        self.email = email
        self.userRole = userRole
    }
    
    func isTokenValid() -> Bool {
        guard let accessToken = accessToken else { return false }
        do {
            let payload = try decodeJWT(accessToken)
            if let exp = payload["exp"] as? TimeInterval {
                let expirationDate = Date(timeIntervalSince1970: exp)
                return expirationDate > Date()
            }
        } catch {
            print("Token decoding failed: \(error)")
        }
        return false
    }
}
