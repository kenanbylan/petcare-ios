//
//  ConstraintsBuilder.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 20.01.2024.

import UIKit

enum AnchorType {
    case top, leading, trailing, bottom, width, height, centerX, centerY
}

//scrollView.applyConstraints { builder in
//    builder.setTargetView(view)
//        .addAnchor(.left,)
//        .addConstant(20)
//}

final class ConstraintsBuilder {
    
    private var view: UIView
    private var targetView: UIView?
    private var anchors: [AnchorType] = []
    private var anchor: AnchorType?
    private var constants: UIEdgeInsets = .zero
    private var constant: CGFloat?
    
    init(view: UIView) {
        self.view = view
    }
    
    func setTargetView(_ targetView: UIView) -> ConstraintsBuilder {
        self.targetView = targetView
        return self
    }
    
    func addAnchor(_ anchor: AnchorType...) -> ConstraintsBuilder {
        self.anchors += anchor
        return self
    }
    
    func addConstant(_ constant: CGFloat) -> ConstraintsBuilder {
        self.constant = constant
        return self
    }
    
    func addConstants(_ constants: UIEdgeInsets) -> ConstraintsBuilder {
        self.constants = constants
        return self
    }
    
    
    func build() {
        guard let target = targetView ?? view.superview else { fatalError("The target view ")}
        
        for anchor in anchors {
            switch anchor {
            case .top:
                view.topAnchor.constraint(equalTo: target.topAnchor, constant: constant ?? 0).isActive = true
            case .leading:
                view.leadingAnchor.constraint(equalTo: target.leadingAnchor, constant: constant ?? 0).isActive = true
            case .trailing:
                view.trailingAnchor.constraint(equalTo: target.trailingAnchor, constant: -constant! ).isActive = true
            case .bottom:
                view.bottomAnchor.constraint(equalTo: target.bottomAnchor, constant: -constant!).isActive = true
            case .width:
                view.widthAnchor.constraint(equalTo: target.widthAnchor, constant:  constants.left + constants.right).isActive = true
            case .height:
                view.heightAnchor.constraint(equalTo: target.heightAnchor, constant: constants.top + constants.bottom).isActive = true
            case .centerX:
                view.centerXAnchor.constraint(equalTo: target.centerXAnchor).isActive = true
            case .centerY:
                view.centerYAnchor.constraint(equalTo: target.centerYAnchor).isActive = true
            }
        }
    }
}

extension UIView {
    func applyConstraints(builder: (ConstraintsBuilder) -> Void) {
        let constraintsBuilder = ConstraintsBuilder(view: self)
        builder(constraintsBuilder)
        constraintsBuilder.build()
    }
}
