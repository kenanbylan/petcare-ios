//
//  ImageLabelBuilder.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.03.2024.
//

import Foundation
import UIKit

final class ImageLabelBuilder {
    private var title: String = ""
    private var imageName: UIImage = UIImage(systemName: "location.circle")!
    private var labelColor: UIColor = AppColors.labelColor
    private var alignment: ImageLabelAlignment = .right
    
    func setTitle(_ title: String) -> ImageLabelBuilder {
        self.title = title
        return self
    }
    
    func setImageName(_ imageName: UIImage) -> ImageLabelBuilder {
        self.imageName = imageName
        return self
    }
    
    func setTitleColor(_ color: UIColor) -> ImageLabelBuilder {
        self.labelColor = color
        return self
    }
    
    func setAligment(_ alignment: ImageLabelAlignment) -> ImageLabelBuilder {
        self.alignment = alignment
        return self
    }
    
    func build() -> ImageLabel {
        let labelImageIcon = ImageLabel()
        labelImageIcon.title = title
        labelImageIcon.imageName = imageName
        labelImageIcon.color = labelColor
        labelImageIcon.alignment = alignment
        return labelImageIcon
    }
}
