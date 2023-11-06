//
//  HeaderView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import UIKit

class HeaderView: UIView {
    var backButton: UIButton!
    var titleLabel: UILabel!
    var notificationButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Header içeriği için butonları ve başlığı oluşturun
        backButton = UIButton()
        backButton.setTitle("Geri", for: .normal)
        addSubview(backButton)
        
        titleLabel = UILabel()
        titleLabel.text = "Başlık"
        addSubview(titleLabel)
        
        notificationButton = UIButton()
        notificationButton.setTitle("Bildirimler", for: .normal)
        addSubview(notificationButton)
        
        // Auto Layout kullanarak yerleştirmeyi ayarlayın
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        notificationButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        notificationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        // Butonları özelleştirin
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        // Geri butonuna tıklama işlevi
    }
    
    @objc private func notificationButtonTapped() {
        // Bildirim butonuna tıklama işlevi
    }
}
