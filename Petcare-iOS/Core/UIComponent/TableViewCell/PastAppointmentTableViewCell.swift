//
//  PastAppointmentTableViewCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import UIKit

final class PastAppointmentTableViewCell: UITableViewCell {
    static let identifier = "PastAppointmentTableViewCell"
    
    private lazy var appointmentDateLabel: CustomLabel = {
        let label = CustomLabel(text: "Randevu Tarihi", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var clinicLabel: CustomLabel = {
        let label = CustomLabel(text: "Klinik Adı", fontSize: 17, fontType: .medium, textColor: AppColors.labelColor)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var animalLabel: CustomLabel = {
        let label = CustomLabel(text: "Hayvan Adı", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        if let myImage = UIImage(named: "splash_transparent") {
            let resizedImage = myImage.resized(to: CGSize(width: 60, height: 35))
            let coloredImage = resizedImage.withTintColor(AppColors.primaryColor)
            imageView.image = coloredImage
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var insideStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 2
        return stack
    }()
    
    private lazy var outsideStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.clipsToBounds = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with appointment: PastAppointment) {
        self.appointmentDateLabel.text = appointment.date
        self.clinicLabel.text = appointment.clinicName
        self.animalLabel.text = appointment.animalName
    }
}

extension PastAppointmentTableViewCell: ViewCoding {
    func setupView() {
        contentView.addSubview(outsideStackView)
        
        outsideStackView.addArrangedSubview(icon)
        outsideStackView.addArrangedSubview(insideStackView)
        outsideStackView.addArrangedSubview(UIView())
        
        insideStackView.addArrangedSubview(clinicLabel)
        insideStackView.addArrangedSubview(animalLabel)
        insideStackView.addArrangedSubview(appointmentDateLabel)
    }
    
    func setupHierarchy() {}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            outsideStackView.topAnchor.constraint(equalTo: self.topAnchor),
            outsideStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            outsideStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            outsideStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            insideStackView.widthAnchor.constraint(equalToConstant: UIScreen.screenWidth / 2)
        ])
    }
}
