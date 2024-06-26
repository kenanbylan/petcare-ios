//
//  ViewCoding.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 8.11.2023.
//

import Foundation

protocol ViewCoding {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
}
