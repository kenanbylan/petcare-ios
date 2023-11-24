import Foundation
import UIKit

class GoogleLoginButton: UIButton {
    
    // İlkleme (Initialization) işlemleri burada yapılabilir
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    ///MARK:  for Storyboard or XIB use
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        setTitle("Google ile Giriş Yap", for: .normal)
        setTitleColor(AppColors.labelColor, for: .normal)
        
        if let image = UIImage(named: "google_icon") {
            image.withTintColor(AppColors.primaryColor)
            let scaledImage = image.resizableImage(withCapInsets: .zero, resizingMode: .tile)
            setImage(scaledImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
        
        imageView?.contentMode = .scaleAspectFit
        backgroundColor = AppColors.bgColor
        titleLabel?.font = AppFonts.medium.font(size: 14)
        
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 3, height: 3)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        print("Google ile giriş yap düğmesine tıklandı.")
    }
}

