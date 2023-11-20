//
//  Font + Enum.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.10.2023.

import UIKit

enum AppFonts {
    case bold
    case medium
    case semibold
    case thin
    case regular

    func font(size: CGFloat ) -> UIFont? {
        var fontName: String
        switch self {
        case .bold:
            fontName = "Poppins-Bold"
        case .medium:
            fontName = "Poppins-Medium"
        case .semibold:
            fontName = "Poppins-SemiBold"
        case .thin:
            fontName = "Poppins-Thin"
        case .regular:
            fontName = "Poppins-Regular"
        }
        return UIFont(name: fontName, size: size)
    }
    
    func font(size: LabelSize) -> UIFont? {
        
        var fontName: String
        switch self {
        case .bold:
            fontName = "Poppins-Bold"
        case .medium:
            fontName = "Poppins-Medium"
        case .semibold:
            fontName = "Poppins-SemiBold"
        case .thin:
            fontName = "Poppins-Thin"
        case .regular:
            fontName = "Poppins-Regular"
        }

        return UIFont(name: fontName, size: size.rawValue)
        
    }
}
