//
//  OnboardingInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation

protocol OnboardingInteractorProtocol: AnyObject {
    var data: [OnboardingModel]? { get }
    func getData()
}

protocol OnboardingInteractorOutputProtocol {
    
}

final class OnboardingInteractor: OnboardingInteractorProtocol {
    var output: OnboardingInteractorOutputProtocol?
    var data: [OnboardingModel]?
    
    let swipeData = [
        OnboardingModel(image: "onboard1", headline: "Make sure always be perfect parent to your pets", subheadline: "Pin your favorite restaurants and create your own food guide"),
        OnboardingModel(image: "onboard2", headline: "SHOW YOU THE LOCATION", subheadline: "Search and locate your favourite restaurant on Maps"),
        OnboardingModel(image: "onboard3", headline: "DISCOVER GREAT RESTAURANTS", subheadline: "Find restaurants shared by your friends and other foodies")
    ]
    
    func getData() {
    }
    
}
