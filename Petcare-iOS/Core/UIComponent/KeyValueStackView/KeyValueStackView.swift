//
//  KeyValueStackView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 16.03.2024.
//

import Foundation
import UIKit

final class KeyValueStackView: UIStackView {
    var data: [(String, String)]? {
        didSet {
            setupStackView()
        }
    }
    
    init(data: [(String, String)]? = nil) {
        super.init(frame: .zero)
        self.data = data
        self.axis = .horizontal
        self.alignment = .fill
        self.spacing = 8
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let data = data else { return }
        
        for (key, value) in data {
            let keyLabel = CustomLabel(text: "", fontSize: 14, fontType: .bold, textColor: AppColors.labelColor)
            keyLabel.text = key
            keyLabel.textAlignment = .left
            
            let valueLabel = CustomLabel(text: "", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
            valueLabel.text = value
            valueLabel.textAlignment = .left
            
            self.addArrangedSubview(keyLabel)
            self.addArrangedSubview(valueLabel)
        }
    }
}

