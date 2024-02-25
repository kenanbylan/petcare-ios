//
//  CustomStackViewBuilder.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.

import Foundation
import UIKit

final class CustomStackViewBuilder {
    private var stackView = CustomStackView()
    
    func withCornerRadius(_ cornerRadius: CGFloat) -> CustomStackViewBuilder {
        stackView.layer.cornerRadius = cornerRadius
        return self
    }
    
    func withBackgroundColor(_ color: UIColor) -> CustomStackViewBuilder {
        stackView.backgroundColor = color
        return self
    }
    
    func withAxis(_ axis: NSLayoutConstraint.Axis) -> CustomStackViewBuilder {
        stackView.axis = axis
        return self
    }
    
    func withLayoutMargins(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CustomStackViewBuilder {
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        
        return self
    }
    
    func withShadow(color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat) -> CustomStackViewBuilder {
        stackView.layer.shadowColor = color
        stackView.layer.opacity = opacity
        stackView.layer.shadowOffset = offset
        stackView.layer.cornerRadius = radius
        return self
    }
    
    func build() -> CustomStackView {
        return stackView
    }
}
