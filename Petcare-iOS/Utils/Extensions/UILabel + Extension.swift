//
//  UILabel + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

final class TitleLabel {
    static func configurationTitleLabel(withText: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = withText
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = AppFonts.bold.font(size: 17)
        titleLabel.textColor = AppColors.primaryColor
        titleLabel.sizeToFit()
        return titleLabel
    }
}

extension UILabel {
    func addImage(image: UIImage, offsetY: CGFloat, lineSpacing: CGFloat, textAfterImage: String) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        
        // Resmin boyutunu ve konumunu ayarla
        let imageSize = image.size
        let imageOffsetX = offsetY
        
        imageAttachment.bounds = CGRect(x: 0, y: offsetY, width: imageSize.width, height: imageSize.height)
        
        // Resim ile birlikte bir NSAttributedString oluştur
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        // Boşluk oluştur
        let spaceString = NSAttributedString(string: " ")
        
        // Label'a resmi ekle
        let mutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString())
        mutableAttributedString.append(spaceString)
        mutableAttributedString.append(attachmentString)
        
        // Eğer textAfterImage varsa, label'a ekle
        if !textAfterImage.isEmpty {
            let textAfterImageAttributedString = NSAttributedString(string: textAfterImage)
            mutableAttributedString.append(spaceString)
            mutableAttributedString.append(textAfterImageAttributedString)
        }
        
        // Label'a tam metni ata
        self.attributedText = mutableAttributedString
        
        // Line spacing ayarla
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = self.textAlignment
        mutableAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedString.length))
    }
}
