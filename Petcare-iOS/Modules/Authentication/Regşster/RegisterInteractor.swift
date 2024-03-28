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
            let userRegister = ["name": name , "surname": surname, "email": email, "password": password]
            print("Request data: \(userRegister)")
            let jsonData = try JSONSerialization.data(withJSONObject: userRegister, options: .prettyPrinted)

            networkManager.request(type: UserRegisterResponse.self , router: .users, method: .post, requestData: jsonData)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print("error: :\(error.localizedDescription)")
                        self.output?.registrationFailure(error: error)
                    }
                } receiveValue: { response in
                    print("User data: \(response)")
                    self.output?.registrationSuccess()
                }
                .store(in: &subscriptions)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}
