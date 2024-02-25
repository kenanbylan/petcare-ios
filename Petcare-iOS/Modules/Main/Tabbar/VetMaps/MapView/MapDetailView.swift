//
//  MapDetailVie.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.02.2024.
//

import UIKit

final class MapDetailView: UIView {
    private lazy var veterinaryName:  UILabel = {
        let label = UILabel()
        label.text = "Example Code"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Diğer bileşenleri buraya ekleyin...
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareDetailView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareDetailView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(veterinaryName)
        
        NSLayoutConstraint.activate([
            veterinaryName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            veterinaryName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            veterinaryName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            veterinaryName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        guard let superview = superview else { return }
        
        let translation = recognizer.translation(in: superview)
        let newYPosition = center.y + translation.y
        
        if newYPosition > superview.frame.height {
            return
        }
        
        center = CGPoint(x: center.x, y: newYPosition)
        recognizer.setTranslation(.zero, in: superview)
        
        if recognizer.state == .ended {
            if newYPosition > superview.frame.height / 2 {
                dismiss()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.center.y = superview.frame.height / 2
                }
            }
        }
    }
    
    func dismiss() {
        guard let superview = superview else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.center.y = superview.frame.height + self.frame.height / 2
        }) { _ in
            self.removeFromSuperview()
        }
    }
}


//import Foundation
//import UIKit
//
//
//final class MapDetailView: UIView {
//    
//    private lazy var veterinaryName:  CustomLabel = {
//        let label = CustomLabel(text: "Example Code", fontSize: 17, fontType: .medium, textColor: AppColors.primaryColor)
//        return label
//    }()
//    
//    private lazy var veterinaryPhone: CustomLabel = {
//        let label = CustomLabel(text: "0534312312", fontSize: 12, fontType: .medium, textColor: AppColors.labelColor)
//        return label
//    }()
//    
//    private lazy var veterinaryAddress: CustomLabel = {
//        let label = CustomLabel(text: "Gebzde Marmaray", fontSize: 12, fontType: .medium, textColor: AppColors.labelColor)
//        return label
//    }()
//    
//    private lazy var appointmentButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .gray
//        button.setTitle("make appointmen", for: .normal)
//        
//        return button
//    }()
//
//    private lazy var stackView: CustomStackView = {
//        return CustomStackViewBuilder()
//            .withAxis(.vertical)
//            .withBackgroundColor(AppColors.customRed)
//            .build()
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        prepareDetailView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func prepareDetailView() {
//        stackView.addArrangedSubview(veterinaryName)
//        stackView.addArrangedSubview(veterinaryPhone)
//        stackView.addArrangedSubview(veterinaryAddress)
//        stackView.addArrangedSubview(appointmentButton)
//        
//        addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: self.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
//    }
//}
//
