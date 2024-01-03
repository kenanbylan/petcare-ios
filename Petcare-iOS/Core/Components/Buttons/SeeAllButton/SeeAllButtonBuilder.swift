//
//  SeeAllButtonBuilder.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

final class SeeAllButtonBuilder {
    private var originalImage: UIImage?
    private var targetHeight: CGFloat = 20.0
    private var rightInset: CGFloat = 4.0
    private var action: (() -> Void)?
    
    func withOriginalImage(_ image: UIImage) -> SeeAllButtonBuilder {
        originalImage = image
        return self
    }
    
    func withTargetHeight(_ height: CGFloat) -> SeeAllButtonBuilder {
        targetHeight = height
        return self
    }
    
    func withRightInset(_ inset: CGFloat) -> SeeAllButtonBuilder {
        rightInset = inset
        return self
    }
    
    func withAction(_ action: @escaping () -> Void) -> SeeAllButtonBuilder {
        self.action = action
        return self
    }
    
    func build() -> SeeAllButton {
        let button = SeeAllButton()
        button.setupButton(withOriginalImage: originalImage,
                            targetHeight: targetHeight,
                            rightInset: rightInset,
                            action: action)
        return button
    }
}
