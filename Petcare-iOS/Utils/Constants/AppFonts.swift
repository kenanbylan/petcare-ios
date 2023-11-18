//
//  Font + Enum.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.10.2023.
//

import UIKit
enum Fonts {
    case bold
    case medium
    case semibold
    case thin
    case light
}

struct AppFonts {
    
    static func font(for style: Fonts, size: CGFloat) -> UIFont? {
        var fontName: String
        
        switch style {
        case .bold:
            fontName = "Kanit-Bold"
        case .medium:
            fontName = "Kanit-Medium"
        case .semibold:
            fontName = "Kanit-SemiBold"
        case .thin:
            fontName = "Kanit-Thin"
        case .light:
            fontName = "Kanit-Light"
        }
        
        return UIFont(name: fontName, size: size)
    }
}
