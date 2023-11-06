//
//  TextButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//
import UIKit

class TextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTitleColor(AppColors.primaryColor, for: .normal)
        self.backgroundColor = .clear
        self.titleLabel?.font = AppFonts.kanitMedium
    }
}
