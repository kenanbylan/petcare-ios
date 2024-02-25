//
//  NSObject.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.02.2024.
//

import Foundation

public extension NSObject {
    @objc class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
