//
//  SplashInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.
//

import Foundation
import UIKit

protocol SplashInteractorProtocol: AnyObject{
    func checkInternetConnection()
    func checkTheme()
    func checkLanguage()
    func getData()
    func userAlreadyExists() -> Bool
    func getLocationCity() -> Void
}

protocol SplashInteractorOutputProtocol {
    func internetConnectionStatus(_ status: Bool)
}

final class SplashInteractor: SplashInteractorProtocol {
    var output: SplashInteractorOutputProtocol?
    
    //    private var networkManager: NetworkManager?
    //    init(networkManager: NetworkManager<EndpointItem>) {
    //        self.networkManager = networkManager
    //    }

    func getLocationCity() {
        
    }
    
    func checkInternetConnection() {
        let status = true
        self.output?.internetConnectionStatus(status)
    }
    
    func checkTheme() {
        
    }
    func checkLanguage() {
        
    }
    
    func getData() {
        
    }
    
    func userAlreadyExists() -> Bool {
        return false
    }
}
