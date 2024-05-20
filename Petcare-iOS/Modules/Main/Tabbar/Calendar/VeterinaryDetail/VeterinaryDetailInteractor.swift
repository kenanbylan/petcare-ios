//
//  VeterinaryDetailInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.03.2024.
//


import Foundation

protocol VeterinaryDetailInteractorProtocol {
    func fetchVeterinaryData()
    func getUserPets()
}

protocol VeterinaryDetailInteractorOutput {
    func getPetsSuccess(response: [PetResponse])
    func getPetsFailure(error: String)
}

final class VeterinaryDetailInteractor: VeterinaryDetailInteractorProtocol {
    var output: VeterinaryDetailInteractorOutput?
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getUserPets() {
        guard let userId = TokenManager.shared.userId else {
            return
        }
        
        let request = GetPets()
        networkManager.sendRequest(urlString: request.url,
                                   method: .get,
                                   headers: request.headers,
                                   responseType: [PetResponse].self) { [weak self] response in
            self?.output?.getPetsSuccess(response: response)
        } errorHandler: { [weak self] error in
            self?.output?.getPetsFailure(error: error.localizedDescription)
        }
    }
    
    func fetchVeterinaryData() {
        
    }
}
