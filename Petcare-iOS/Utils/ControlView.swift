//
//  ControlView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation
import UIKit

class ControlView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = AppColors.bgColor
        
        let cornerRadius: CGFloat = 40
        let maskPath = UIBezierPath(roundedRect: bounds,
                                   byRoundingCorners: [.topLeft, .topRight],
                                   cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
