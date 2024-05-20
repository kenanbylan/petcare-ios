//
//  SelectPetView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 1.01.2024.

import UIKit

protocol SelectPetViewDelegate: AnyObject {
    func didSelect(_ view: SelectPetView)
}

final class SelectPetView: UIView {
    var petType: String = ""
    
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    weak var delegate: SelectPetViewDelegate?
    
    func setText(_ text: String) {
        petType = text
        label.text = text
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = AppFonts.medium.font(size: 14)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        updateAppearance()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = AppColors.bgColor
        layer.cornerRadius = 20
        addShadow(shadowColor: AppColors.bgColor.cgColor)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: UIScreen.screenWidth / 8.5)
        ])
    }
    
    private func updateAppearance() {
        if isSelected {
            backgroundColor = AppColors.primaryColor
            label.textColor = AppColors.customWhite
        } else {
            backgroundColor = AppColors.bgColor
            label.textColor = AppColors.labelColor
        }
    }
    
    func setSelection(selected: Bool) {
        // Eğer bu öğe zaten seçili ise işlem yapma.
        guard !isSelected else { return }
        
        // Eğer bu öğe seçiliyse, diğer tüm öğeleri seçili olmamış duruma getir.
        delegate?.didSelect(self)
        
        // Diğer tüm öğelerin seçili olmamış duruma getirilmesi
        for view in superview?.subviews ?? [] {
            if let petView = view as? SelectPetView, petView != self {
                petView.isSelected = false
            }
        }
        
        isSelected = true
    }
    
    @objc private func viewTapped() {
        setSelection(selected: true)
    }
}

extension SelectPetView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
}
