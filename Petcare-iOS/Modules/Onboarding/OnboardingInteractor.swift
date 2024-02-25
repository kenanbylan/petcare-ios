//
//  OnboardingInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation

protocol OnboardingInteractorProtocol: AnyObject {
    var data: [OnboardingModel]? { get }
    func userAlreadyExists() -> Bool
}

protocol OnboardingInteractorOutputProtocol {
    
}

final class OnboardingInteractor: OnboardingInteractorProtocol {
    var output: OnboardingInteractorOutputProtocol?
    var data: [OnboardingModel]?
    
    func userAlreadyExists() -> Bool {
        // Kullanıcı daha önceden appi kurduysa ve login olduysa bu ekran gösterilmez. Kontrolu yapılmalıdır.
        
        
//        do {
//            let user = try coreData.fetchUser()
//            return user.count != 0
//        } catch {
//            return false
//        }
        
        return false
    }
}
