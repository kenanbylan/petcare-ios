//
//  String + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.11.2023.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localizedString, args)
    }
}
