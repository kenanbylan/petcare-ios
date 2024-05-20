//
//  NearbyList.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import Foundation
import UIKit

final class NearbyListTableViewCell: UITableViewCell {
    static let identifier = "NearbyListTableViewCell"
    
    private lazy var title: CustomLabel = {
        let label = CustomLabel(text: "Çınar Veteriner", fontSize: 17, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var address: CustomLabel = {
        let label = CustomLabel(text: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var distance: CustomLabel = {
        let label = CustomLabel(text: "", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        let myImage = UIImage(named: "patiShape")
        let resizedImage = myImage!.resized(to: CGSize(width: 35, height: 35))
        image.image = resizedImage
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var insideStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var outsideStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 12
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.clipsToBounds = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
        accessoryType = .disclosureIndicator //TODO: Research me
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with nearbyList: NearbyPlace) {
        self.title.text = nearbyList.placeTitle
        self.address.text = nearbyList.address
        self.distance.text = nearbyList.distance.formatAsDistance()
    }
    
    func configureContractCell(with contractVet: UserRegisterRequest) {
        self.title.text = contractVet.address?.clinicName
        
        if let address = contractVet.address {
            var fullAddress = ""
            if let clinicCity = address.clinicCity { fullAddress += clinicCity }
            
            if let clinicDistrict = address.clinicDistrict {
                if !fullAddress.isEmpty { fullAddress += ", " }
                fullAddress += clinicDistrict
            }
            
            if let clinicStreet = address.clinicStreet {
                if !fullAddress.isEmpty {
                    fullAddress += ", " }
                fullAddress += clinicStreet
            }
            
            if let clinicNo = address.clinicNo {
                if !fullAddress.isEmpty {
                    fullAddress += ", "
                }
                fullAddress += clinicNo
            }
            
            if let apartmentNo = address.apartmentNo {
                if !fullAddress.isEmpty {
                    fullAddress += ", "
                }
                fullAddress += apartmentNo
            }
            self.address.text = fullAddress
        } else {
            self.address.text = "Address not available"
        }
    }
}

extension NearbyListTableViewCell: ViewCoding {
    func setupView() {
        contentView.addSubview(outsideStackView)
        
        outsideStackView.addArrangedSubview(icon)
        outsideStackView.addArrangedSubview(insideStackView)
        outsideStackView.addArrangedSubview(distance)
        outsideStackView.addArrangedSubview(UIView())
        
        insideStackView.addArrangedSubview(title)
        insideStackView.addArrangedSubview(address)
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
