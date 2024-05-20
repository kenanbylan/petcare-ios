//
//  MultiSelectView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//
import UIKit

protocol MultiSelectViewDelegate: AnyObject {
    func didSelect(_ view: MultiSelectView, isSelected: Bool)
}

final class MultiSelectView: UIView {
    var itemTitle: String = ""
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
            delegate?.didSelect(self, isSelected: isSelected)
        }
    }
    
    weak var delegate: MultiSelectViewDelegate?
    
    func setText(_ text: String) {
        itemTitle = text
        label.text = text
    }
    
    
    private lazy var label: CustomLabel = {
        let title = CustomLabel(text: "DateListInfoDetailView_header".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.customWhite)
        title.textAlignment = .center
        return title
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
        backgroundColor = .lightGray
        layer.cornerRadius = 12
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? .systemGreen : .lightGray
        label.textColor = isSelected ? .white : .black
    }
    
    @objc private func viewTapped() {
        isSelected = !isSelected
    }
}
