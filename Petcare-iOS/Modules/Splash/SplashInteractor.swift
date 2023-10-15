//
//  SplashInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import Foundation

protocol SplashInteractorInterface {
    func checkInternetConnection()
    func checkDeviceManager()
    func checkUserLogin()
    func checkTheme()
    func checkLanguage()
}

protocol SplashInteractorOutput {
    func internetConnectionStatus(_ status: Bool)
}


final class SplashInteractor {
    var output: SplashInteractorOutput?
     
}

extension SplashInteractor : SplashInteractorInterface {
    func checkInternetConnection() {
        let internetStatus = true
        self.output?.internetConnectionStatus(internetStatus)
    }
    func checkDeviceManager() { }
    func checkUserLogin() { }
    func checkTheme() { }
    func checkLanguage() { }
}
