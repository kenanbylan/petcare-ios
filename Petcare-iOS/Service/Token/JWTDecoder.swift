//
//  JWTDecoder.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.05.2024.
//

import Foundation

final class JWTDecoder {
    enum DecodeErrors: Error {
        case badToken
        case other
    }
    
    func decode(jwtToken jwt: String) throws -> [String: Any] {
        
        func base64Decode(_ base64: String) throws -> Data {
            let base64 = base64
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
            guard let decoded = Data(base64Encoded: padded) else {
                throw DecodeErrors.badToken
            }
            return decoded
        }
        
        func decodeJWTPart(_ value: String) throws -> [String: Any] {
            let bodyData = try base64Decode(value)
            let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
            guard let payload = json as? [String: Any] else {
                throw DecodeErrors.other
            }
            return payload
        }
        
        let segments = jwt.components(separatedBy: ".")
        return try decodeJWTPart(segments[1])
    }
}


//Usage:
/*
 
 // Kullanım
 do {
 let jwtPayload = try TokenManager.shared.decodeJWT("your_jwt_token_here")
 // JWT içeriğiyle işlemleri yapın
 } catch {
 // Hata durumunda işlemleri yapın
 }
 
 */
