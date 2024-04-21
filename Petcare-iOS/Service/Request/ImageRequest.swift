//
//  ImageRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.
//

import UIKit

struct ImageRequest: DataRequest {
    var contentType: String? { "application/json" } // Content-Type belirtildi

    let url: String
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(
                domain: ErrorResponse.invalidResponse.rawValue,
                code: 13,
                userInfo: nil
            )
        }
        
        return image
    }
}
