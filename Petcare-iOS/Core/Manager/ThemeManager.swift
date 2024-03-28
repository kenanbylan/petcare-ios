//
//  ThemeManager.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 17.03.2024.
//

import Foundation
import UIKit

enum AppTheme: String {
    case light, dark, device
}

final class ThemeManager {
    static let shared = ThemeManager()
    
    private init() {}
    
    func getCurrentTheme() -> AppTheme {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme") {
            return AppTheme(rawValue: savedTheme) ?? .light
        }
        return .light
    }
    
    func applyTheme(_ theme: AppTheme) {
        UserDefaults.standard.set(theme.rawValue, forKey: "selectedTheme")
        
        switch theme {
        case .light:
            // Apply light theme colors
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
                // Set light theme colors for UI elements
                window.tintColor = .black
                // Set other UI elements' colors as needed
            }
        case .dark:
            // Apply dark theme colors
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
                // Set dark theme colors for UI elements
                window.tintColor = .white
                // Set other UI elements' colors as needed
            }
        case .device:
            // Apply device theme colors
            // Do nothing or apply device-specific colors
            break
        }
    }
    
}
