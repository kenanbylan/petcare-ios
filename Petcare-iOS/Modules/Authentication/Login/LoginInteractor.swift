//
//  LoginInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation
import Combine

protocol LoginInteractorProtocol {
  //  func checkUserLogin(onCompletion: @escaping(Bool) -> ())    
}

protocol LoginInteractorOutput {
    func internetConnectionStatus(_ status: Bool)
}

final class LoginInteractor: LoginInteractorProtocol, ObservableObject {
    var output: LoginInteractorOutput?
    /*
    private let networkService: NetworkService
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func checkUserLogin(onCompletion: @escaping(Bool) -> ()) {
        let response: AnyPublisher<UserModel,APIError> = networkService.request(.signIn, headers: nil, parameters: nil)
        response
            .sink { completion in
                switch completion {
                case .finished:
                    print("Compoetion: \(completion)")
                    
                case .failure(let error):
                    print("Error: \(error)")
                    onCompletion(false)
                }
                
            } receiveValue: { response in
                print("response : \(response)")
            }
            .store(in: &cancellables)
    }
     */
}
