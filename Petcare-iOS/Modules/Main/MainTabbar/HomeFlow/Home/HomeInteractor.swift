//
//  HomeInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol HomeInteractorProtocol {
    func getPetsbyId() -> Void
    func getPetsDetail(petsId: String) -> Void
}

protocol HomeInteractorOutput {
    func getPetsSuccess(response: [PetResponse])
    func getPetsFailure(error: String)
    
    func getPetDetailSucces(response: PetResponse)
    func getPetDetailFailure(error: String)
}


final class HomeInteractor : HomeInteractorProtocol {
    var output: HomeInteractorOutput?
    var networkManager: NetworkManager
    
    init( networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getPetsbyId() {
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
    
    func getPetsDetail(petsId: String) {
        let request = GetPetById(petId: petsId)
        networkManager.sendRequest(urlString: request.url,
                                   method: request.method,
                                   headers: request.headers,
                                   responseType: PetResponse.self) { [weak self] response in
            
            DispatchQueue.main.async {
                self?.output?.getPetDetailSucces(response: response)
            }
            
        } errorHandler: { [weak self] error in
            self?.output?.getPetDetailFailure(error: error.localizedDescription)
        }
    }
}
