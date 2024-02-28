//
//  Int + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.11.2023.
//

import UIKit

extension Double {
    var wPercent: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return CGFloat(self) * screenWidth / 100.0
    }
    
    var hPercent: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return CGFloat(self) * screenHeight / 100.0
    }
}

///MARK: Usage
//let widthValue = 10.wPercent
//let heightValue = 30.hPercent
