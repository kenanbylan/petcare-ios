//
//  CustomStackView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.11.2023.
//

import Foundation
import UIKit

class UICustomStackView: UIStackView {

    init(axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 20, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
