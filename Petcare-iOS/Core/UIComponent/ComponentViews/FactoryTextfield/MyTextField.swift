//
//  LoginTextField.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.11.2023.
//

import Foundation
import UIKit

///MARK: - Custom Textfields
class MyTextField: CustomTextFieldBase {
    
    func validate() -> Bool {
        let text = self.text ?? ""
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
