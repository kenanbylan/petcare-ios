//
//  PasswordValidationVİew.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 22.11.2023.
//

import Foundation
import UIKit

class PasswordValidationView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()

        // Inıtializer
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupUI()
        }

        private func setupUI() {
            // Gerekli arayüz elemanlarını ekleyin
            addSubview(imageView)
            addSubview(textLabel)

            // İhtiyacınıza göre arayüz elemanlarını düzenleyin
            // Bu örnekte sadece basit bir düzen kullanıyorum, sizin ihtiyacınıza göre özelleştirebilirsiniz
            imageView.translatesAutoresizingMaskIntoConstraints = false
            textLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 50), // İhtiyacınıza göre ayarlayın

                textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        // Validasyon sonuçlarına göre görünümü güncelleyen fonksiyon
        func updateView(isValid: Bool) {
            if isValid {
                imageView.image = UIImage(named: "validImage") // Geçerli durumu gösteren bir resim
                textLabel.textColor = .green
                textLabel.text = "Geçerli Şifre"
            } else {
                imageView.image = UIImage(named: "invalidImage") // Geçersiz durumu gösteren bir resim
                textLabel.textColor = .red
                textLabel.text = "Geçersiz Şifre"
            }
        }
}
