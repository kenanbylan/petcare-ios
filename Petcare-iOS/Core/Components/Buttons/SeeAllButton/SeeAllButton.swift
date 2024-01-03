//
//  SeeAllButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 26.12.2023.
//

import Foundation
import UIKit

final class SeeAllButton: UIButton {
    
    var buttonTappedAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtonViews()
    }
    private func setupButtonViews() {
        
        if let originalImage = UIImage(named: "patiShape") {
            let aspectRatio = originalImage.size.width / originalImage.size.height
            let targetHeight: CGFloat = 20.0 // Set your desired height
            
            // Calculate the width to maintain aspect ratio
            let targetWidth = targetHeight * aspectRatio
            
            let resizedImage = originalImage.resized(to: CGSize(width: targetWidth, height: targetHeight))
            
            setImage(resizedImage, for: .normal)
            imageView?.contentMode = .scaleAspectFit
            
            
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

            // Add action for button tap
            addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped() {
        buttonTappedAction?()
    }
}


