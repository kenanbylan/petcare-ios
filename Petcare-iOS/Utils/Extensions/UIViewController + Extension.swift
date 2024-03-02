//
//  UIViewController + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.


import UIKit
import SwiftUI

extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {
        
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
    
    func showPreview() -> some View  {
        Preview(viewController: self)
    }
}
