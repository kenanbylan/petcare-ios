//
//  CustomButtonTheem.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import Foundation
import UIKit

protocol CustomButtonTheme {
    var title: String { get set }
    var image: UIImage? { get set }
    var backgroundColor: UIColor { get }
    var tintColor: UIColor { get }
    var textFont: UIFont? { get set }
}

struct PrimaryCustomButtonTheme: CustomButtonTheme {
    var title: String
    var image: UIImage?
    var backgroundColor: UIColor = AppColors.primaryColor
    var tintColor: UIColor = AppColors.customWhite
    var textFont: UIFont? = AppFonts.bold.font(size: 24)
}

struct RedCustomButtonTheme: CustomButtonTheme {
    var title: String
    var image: UIImage?
    var backgroundColor: UIColor = AppColors.customRed
    var tintColor: UIColor = AppColors.customWhite
    var textFont: UIFont? = AppFonts.bold.font(size: 24)
    
}
