//
//  PatiButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.
//

import UIKit

protocol PatiButtonDelegate: AnyObject {
    func patiButtonClicked(_ sender: PatiButton)
}

final class PatiButton: UIButton {
    weak var delegate: PatiButtonDelegate?
    
    // Ek özellikler
    var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
            adjustContent()
        }
    }
    
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
            adjustContent()
        }
    }
    
    // Ince border'lı dikdörtgen şeklinde düğme oluşturma
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    private func configureButton() {
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addShadow(shadowColor: AppColors.primaryColor.cgColor)
        layer.cornerRadius = 8 // İsteğe bağlı: Köşelerin yuvarlatılması
        layer.borderWidth = 1 // İnce bir border eklemek
        layer.borderColor = UIColor.lightGray.cgColor // Border rengi
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        contentHorizontalAlignment = .center // İçeriği yatayda ortala
        contentVerticalAlignment = .center // İçeriği dikeyde ortala
        
        if #available(iOS 15.0, *) {
            var newConfiguration = UIButton.Configuration.plain()
            newConfiguration.imagePadding = 10 // Görüntüye sağ boşluk ekle
            newConfiguration.titlePadding = 10 // Metne sol boşluk ekle
            configuration = newConfiguration
        }
    }

    
    // Görüntüdeki dokunma hissini ekleyerek animasyonlu düğme geri bildirimi sağlama
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 1.5, y: 1.5) : .identity
            }
        }
    }
    
    // Düğmeye tıklanma olayını ileten fonksiyon
    @objc private func buttonClicked() {
        delegate?.patiButtonClicked(self)
    }
    
    // Metin ve görüntüye göre içeriği ayarla
    private func adjustContent() {
        if let image = image, let title = title {
            // Hem görüntü hem de metin varsa, ikisini yanyana yerleştir
            setImage(image, for: .normal)
            setTitle(title, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10) // Görüntüye sağ boşluk ekle
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10) // Metne sol boşluk ekle
        } else if let title = title {
            // Sadece metin varsa, metni düğmenin ortasına yerleştir
            setTitle(title, for: .normal)
            setImage(nil, for: .normal)
        } else {
            // Sadece görüntü varsa, görüntüyü düğmenin ortasına yerleştir
            setImage(image, for: .normal)
            setTitle(nil, for: .normal)
        }
    }
}
