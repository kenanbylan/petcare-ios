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
    func checkUserSession()

}

protocol SplashInteractorOutputProtocol {
    func internetConnectionStatus(_ status: Bool)
    func userSessionStatus(_ loggedIn: Bool)
}

final class SplashInteractor: SplashInteractorProtocol {
    var output: SplashInteractorOutputProtocol?
    
    func checkInternetConnection() {
        let internet = NetworkMonitor.shared.isConnected
        self.output?.internetConnectionStatus(internet)
    }
    
    func checkUserSession() {
        // TokenManager.isTokenValid()
        let loggedIn = true  // kullanıcı oturumunun kontrolü
        output?.userSessionStatus(loggedIn)
    }
    
    func checkLanguage() {
        let preferredLanguages = Locale.preferredLanguages
        print("Device Language: \(preferredLanguages)")
    }
}
