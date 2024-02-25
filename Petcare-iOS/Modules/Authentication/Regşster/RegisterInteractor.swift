//
//  RegisterInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation
import Combine

protocol RegisterInteractorProtocol {
    func registerUser(name: String, surname: String, email: String, password: String) -> Void
}

protocol RegisterInteractorOutput: AnyObject {
    func registrationSuccess()
    func registrationFailure(error: Error)
}

final class RegisterInteractor : RegisterInteractorProtocol {
    
    var subscriptions = Set<AnyCancellable>()

    weak var output: RegisterInteractorOutput?
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func registerUser(name: String, surname: String, email: String, password: String) {
        do {
            let requestData: [String: Any] = ["name": name, "surname": surname, "email": email,"password": password]
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            networkManager.request(type: UserRegister.self , router: .register, method: .post, requestData: jsonData)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.output?.registrationFailure(error: error)
                    }
                } receiveValue: { userData in
                    print("User data: \(userData)")
                    self.output?.registrationSuccess()
                }
                .store(in: &subscriptions)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}
