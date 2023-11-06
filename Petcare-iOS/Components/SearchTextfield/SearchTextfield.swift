//
//  SearchTextfield.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation
import UIKit

import UIKit

final class SearchTextField: UITextField {
    private var searchIconImageView: UIImageView!
    private var placeholderName: String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        
    }
    
    private func setupUI() {
        
        placeholder = "Search"
        
        searchIconImageView = UIImageView(image: UIImage(named: "magnifyingglass"))
        searchIconImageView.contentMode = .center
        searchIconImageView.tintColor = .systemOrange
        leftView = searchIconImageView
        leftViewMode = .always
        
        borderStyle = .bezel
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }

}


