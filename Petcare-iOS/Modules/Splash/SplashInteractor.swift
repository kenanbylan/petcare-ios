//
//  SplashInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.

import Foundation
import UIKit

protocol SplashInteractorProtocol: AnyObject{
    func checkInternetConnection()
    func checkLanguage()
}

protocol SplashInteractorOutputProtocol {
    func internetConnectionStatus(_ status: Bool)
}

final class SplashInteractor: SplashInteractorProtocol {
    var output: SplashInteractorOutputProtocol?
    
    func checkInternetConnection() {
        let internet = false
        self.output?.internetConnectionStatus(internet)
    }
    
    func checkLanguage() {
        let preferredLanguages = Locale.preferredLanguages
        print("Device Language: \(preferredLanguages)")
    }
}
