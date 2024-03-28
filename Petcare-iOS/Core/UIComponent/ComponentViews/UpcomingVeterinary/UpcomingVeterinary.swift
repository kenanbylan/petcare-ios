//
//  UpcomingVeterinary.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 30.12.2023.
import UIKit

final class UpcomingVeterinary: UIView {
    private lazy var veterinaryAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bird")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var veterinaryName: CustomLabel = {
        let label = CustomLabel(text: "Happys Veterinary Shop", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var veterinaryDateLabel: CustomLabel = {
        let label = CustomLabel(text: "Tuesday, July 15", fontSize: 12, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var veterinaryTimeLabel: CustomLabel = {
        let label = CustomLabel(text: "08:00 AM", fontSize: 12, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution  = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution  = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var outSideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution  = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        prepareVeterinaryViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareVeterinaryViews() {
        veterinaryAvatar.clipsToBounds = true
        veterinaryAvatar.layer.cornerRadius = 20
        dateStackView.layer.cornerRadius = 8
        
        backgroundColor = AppColors.customBlue
        layer.cornerRadius = 12
        
        veterinaryAvatar.addShadow(shadowColor: AppColors.bgColor.cgColor)
        veterinaryAvatar.layer.cornerRadius = 12
        veterinaryAvatar.backgroundColor = AppColors.customBlue
    }
}

extension UpcomingVeterinary: ViewCoding {
    func setupView() {
        self.addSubview(outSideStackView)
        veterinaryAvatar.backgroundColor = AppColors.customBlue
        dateStackView.backgroundColor = AppColors.bgColor.withAlphaComponent(0.6)
    }
    
    func setupHierarchy() {
        dateStackView.addArrangedSubview(veterinaryDateLabel)
        dateStackView.addArrangedSubview(veterinaryTimeLabel)
        informationStackView.addArrangedSubview(veterinaryName)
        informationStackView.addArrangedSubview(dateStackView)
        outSideStackView.addArrangedSubview(veterinaryAvatar)
        outSideStackView.addArrangedSubview(UIView())
        outSideStackView.addArrangedSubview(informationStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            veterinaryAvatar.leadingAnchor.constraint(equalTo: outSideStackView.leadingAnchor,constant: 8),
            veterinaryAvatar.heightAnchor.constraint(equalTo: outSideStackView.heightAnchor, multiplier: 1),
            veterinaryAvatar.widthAnchor.constraint(equalTo: veterinaryAvatar.heightAnchor),
            
            informationStackView.leadingAnchor.constraint(equalTo: veterinaryAvatar.trailingAnchor,constant: 16),
            veterinaryName.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            
            dateStackView.heightAnchor.constraint(equalToConstant: 30),
            veterinaryDateLabel.leadingAnchor.constraint(equalTo: dateStackView.leadingAnchor, constant: 8),
            
            outSideStackView.topAnchor.constraint(equalTo: self.topAnchor,constant:  8),
            outSideStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            outSideStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            outSideStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
