//
//  CustomTextView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.03.2024.
//

import Foundation
import UIKit

final class CustomTextView: UITextView {
    
    struct Builder {
        var text: String?
        var textColor: UIColor?
        var font: UIFont?
        var shadowColor: UIColor?
        var shadowOffset: CGSize?
        var cornerRadius: CGFloat?
        var borderWidth: CGFloat?
        var borderColor: UIColor?
        var height: CGFloat?
        
        init() {}
        
        func text(_ text: String?) -> Builder {
            var builder = self
            builder.text = text
            return builder
        }
        
        func textColor(_ color: UIColor?) -> Builder {
            var builder = self
            builder.textColor = color
            return builder
        }
        
        func font(_ font: UIFont?) -> Builder {
            var builder = self
            builder.font = font
            return builder
        }
        
        func shadowColor(_ color: UIColor?) -> Builder {
            var builder = self
            builder.shadowColor = color
            return builder
        }
        
        func shadowOffset(_ offset: CGSize?) -> Builder {
            var builder = self
            builder.shadowOffset = offset
            return builder
        }
        
        func cornerRadius(_ radius: CGFloat?) -> Builder {
            var builder = self
            builder.cornerRadius = radius
            return builder
        }
        
        func height(_ height: CGFloat?) -> Builder {
            var builder = self
            builder.height = height
            return builder
        }
        
        func borderWidth(_ width: CGFloat?) -> Builder {
            var builder = self
            builder.borderWidth = width
            return builder
        }
        
        func borderColor(_ color: UIColor?) -> Builder {
            var builder = self
            builder.borderColor = color
            return builder
        }
        
        func build() -> CustomTextView {
            let textView = CustomTextView()
            textView.text = text
            textView.textColor = textColor
            textView.font = font
            textView.layer.shadowColor = shadowColor?.cgColor
            textView.layer.shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
            textView.layer.cornerRadius = cornerRadius ?? 0
            textView.layer.borderWidth = borderWidth ?? 0
            textView.layer.borderColor = borderColor?.cgColor
            textView.heightAnchor.constraint(equalToConstant: height ?? 200).isActive = true
            textView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom:0, right: 0)
            return textView
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = AppColors.borderColor!.cgColor
    }
}
