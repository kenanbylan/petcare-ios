//
//  Decoders.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 24.02.2024.
//

import Foundation

public enum Decoders {
    static let Decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
