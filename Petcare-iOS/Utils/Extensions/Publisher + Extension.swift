//
//  Publisher + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import Foundation
import Combine


extension Publisher where Self.Output == String, Failure == Never {
    func validateText(
        validationType: ValidatorType
    ) -> AnyPublisher<ValidationState, Never> {
        let validator = ValidatorFactory.validateForType(type: validationType)
        return validator.validate(publisher: self.eraseToAnyPublisher())
    }
}
