//
//  ClinicDetailsViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 25.02.2024.
//

import Foundation
import UIKit
import MapKit


class ClinicDetailsViewController: UIPageViewController {
    private let address: String
    
    init(address: String) {
        self.address = address
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        setupPages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPages() {
        dataSource = self
        view.backgroundColor = AppColors.primaryColor
    }
}

extension ClinicDetailsViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil // Yarım sayfa, geriye dönüş olmayacak
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil // Yarım sayfa, ileriye gitme olmayacak
    }
}
