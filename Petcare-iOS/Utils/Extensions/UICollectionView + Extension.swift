//
//  UICollectionView + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.03.2024.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerNib(with identifier: String) {
        self.register(UINib(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
    }
    
    func registerCodedCell(with cellClass: AnyClass) {
        let identifier = String(describing: cellClass.self)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeCell<T>(cellClass : T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
