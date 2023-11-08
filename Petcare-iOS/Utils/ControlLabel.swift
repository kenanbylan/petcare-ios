//
//  ControlLabel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.

import UIKit

enum labelTypeEnum {
    case h1
    case h2
    case h3
}

enum colorStyle {
    case primaryColor
    case darkColor
    case lightColor
    case white
}

class ControlLabel: UILabel {
    public private(set) var labelType: labelTypeEnum
    public private(set) var labelText: String
    public private(set) var labelColor: colorStyle
    
    init(labelText: String, labelType: labelTypeEnum, labelColor: colorStyle) {
        self.labelText = labelText
        self.labelType = labelType
        self.labelColor = labelColor
        
        super.init(frame: .zero)
        self.configureLabelColor()
        self.configureLabelColor()
        
        self.translatesAutoresizingMaskIntoConstraints = false //For AutoLayout
        let attributedString = NSMutableAttributedString(string: labelText)
        self.attributedText = attributedString //Setup Label to AttributedString for custom font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabelColor() {
        switch labelColor {
        case .primaryColor:
            self.textColor = AppColors.primaryColor
        case .darkColor:
            self.textColor = AppColors.customDarkGray
        case .lightColor:
            self.textColor = AppColors.customGray
        case .white:
            self.textColor = AppColors.customWhite
        }
    }
    
    private func configureLabelStyle() {
        switch labelType {
        case .h1:
            self.font = UIFont(name: "Poppins-Bold", size: 24)
        case .h2:
            self.font = UIFont(name: "Poppins-Bold", size: 16)
        case .h3:
            self.font = UIFont(name: "Poppins-Bold", size: 12)
            
        }
    }
    
}


