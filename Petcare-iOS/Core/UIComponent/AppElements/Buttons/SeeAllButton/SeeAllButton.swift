//
//  SeeAllButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 26.12.2023.

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
        
    }
    
    func setupButton(withOriginalImage image: UIImage?,
                             targetHeight: CGFloat,
                             rightInset: CGFloat,
                             action: (() -> Void)?) {
        guard let originalImage = image else { return }

        let aspectRatio = originalImage.size.width / originalImage.size.height
        let targetWidth = targetHeight * aspectRatio
        let resizedImage = originalImage.resized(to: CGSize(width: targetWidth, height: targetHeight))

        setImage(resizedImage, for: .normal)
        imageView?.contentMode = .scaleAspectFit

        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightInset)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        buttonTappedAction = action

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        buttonTappedAction?()
    }
}
