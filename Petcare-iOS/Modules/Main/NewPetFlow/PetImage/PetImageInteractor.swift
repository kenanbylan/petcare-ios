//
//  PetImageInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import Foundation

protocol PetImageInteractorProtocol {
    func savePetRequest(petData: PetInfoModel)
}

protocol PetImageInteractorOutput {
    func petsRegisterSuccess(response: PetResponse)
    func petsRegisterFailure(error: ExceptionErrorHandle)
    func petsRegisterFailure(error: String)
}

final class PetImageInteractor: PetImageInteractorProtocol {
    var output: PetImageInteractorOutput?
    var networkManager: NetworkManager
    
    init( networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func savePetRequest(petData: PetInfoModel) {
        guard let userId = TokenManager.shared.userId, let birthDate = petData.birthDate else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDateString = dateFormatter.string(from: birthDate)
        
        let request = SavePetRequest(userId: userId,
                                     name: petData.name,
                                     type: petData.type,
                                     gender: nil,
                                     image: petData.image,
                                     specialInfo: petData.specialInfo,
                                     height: Double(petData.height),
                                     weight: Double(petData.weight),
                                     birthDate: birthDateString)
        
        networkManager.sendRequest(urlString: request.url,
                                   method: request.method,
                                   body: request.body,
                                   headers: request.headers,
                                   responseType: PetResponse.self,
                                   successHandler: { [weak self] response in
            self?.output?.petsRegisterSuccess(response: response)
        },
                                   errorHandler: { [weak self] error in
            self?.output?.petsRegisterFailure(error: error.localizedDescription)
        })
    }
}
