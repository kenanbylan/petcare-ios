//
//  UIImage + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 27.12.2023.
//

import UIKit

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
