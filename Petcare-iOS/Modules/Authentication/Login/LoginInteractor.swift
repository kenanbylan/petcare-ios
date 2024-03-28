//
//  LoginInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import Combine

protocol LoginInteractorProtocol {
    func login(email: String, password: String) -> Void
}

protocol LoginInteractorOutput {
    func registrationSuccess()
    func registrationFailure(error: Error)
}

final class LoginInteractor: LoginInteractorProtocol, ObservableObject {
    var output: LoginInteractorOutput?
    let networkManager: NetworkManager
    
    var subscriptions = Set<AnyCancellable>()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func login(email: String, password: String) {
        let requestData: [String: Any] = ["email": email, "password": password]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            networkManager.request(type: User.self , router: .login, method: .post, requestData: jsonData)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.output?.registrationFailure(error: error)
                    }
                } receiveValue: { response in
                    print("Response: \(response)")
                    self.output?.registrationSuccess()
                }
                .store(in: &subscriptions)
            
        } catch {
            
        }
        
        
        
    }
    
}
