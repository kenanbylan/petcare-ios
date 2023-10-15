//
//  OnboardingInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation

protocol OnboardingInteractorInterface: AnyObject {
    var data: [OnboardingModel]? { get }
}

final class OnboardingInteractor: OnboardingInteractorInterface {
    var data: [OnboardingModel]?
    
}
