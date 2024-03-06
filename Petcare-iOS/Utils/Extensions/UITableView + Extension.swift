//
//  UITableView + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.03.2024.
//

import UIKit

extension UITableView {
    func registerNib(with identifier: String) {
        self.register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
    
    func registerCodedCell(with cellClass: AnyClass) {
        let identifier = String(describing: cellClass.self)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeCell<T>(cellClass : T.Type, indexPath: IndexPath) -> T where T: UITableViewCell {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
