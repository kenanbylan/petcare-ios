//
//  SelectPetView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 1.01.2024.

import UIKit

protocol PetTypeDelegate: AnyObject {
    func didSelectPetType(_ petType: String)
}

final class SelectPetView: UIView {

    private var petType: String = ""
    weak var delegate: PetTypeDelegate?
    
    private var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
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
        setupGesture()
        updateAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = AppColors.bgColor
        layer.cornerRadius = 20
        addShadow(shadowColor: AppColors.bgColor2!.cgColor)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: UIScreen.screenWidth / 8.5)
        ])
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        delegate?.didSelectPetType(petType)

        if let superview = superview {
            for subview in superview.subviews {
                if let otherPetTypeView = subview as? SelectPetView, otherPetTypeView != self {
                    otherPetTypeView.setSelection(selected: false)
                }
            }
        }
        setSelection(selected: true)
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
        isSelected = selected
        updateAppearance()

        UIView.animate(withDuration: 0.3) {
            self.transform = selected ? CGAffineTransform(scaleX: 1.05, y: 1.05) : .identity
        }
    }
}
