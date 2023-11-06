//
//  ControlLabel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import UIKit

class ControlLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.textColor = AppColors.primaryColor
        self.font = AppFonts.kanitMedium
        self.textAlignment = .center
        self.backgroundColor = .clear
        self.lineBreakMode = .byWordWrapping
    }
}
