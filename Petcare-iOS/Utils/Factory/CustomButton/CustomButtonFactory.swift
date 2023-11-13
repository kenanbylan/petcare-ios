//
//  CustomButtonFactory.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import Foundation

struct CustomButtonFactory {
    static func createButton(theme: CustomButtonTheme) -> CustomButton {
        let button = CustomButton()
        button.applyTheme(theme)
        return button
    }
}
