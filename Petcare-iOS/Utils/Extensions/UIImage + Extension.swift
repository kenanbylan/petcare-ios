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
    
    convenience init?(base64String: String) {  //Araştır.
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data)
    }
}
