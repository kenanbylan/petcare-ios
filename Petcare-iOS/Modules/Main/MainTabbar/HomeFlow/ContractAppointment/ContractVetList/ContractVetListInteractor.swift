//
//  ContractVetListInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation

protocol ContractVetListInteractorProtocol {
    func getContractVetList() -> Void
}

protocol ContractVetListInteractorOutput {
    func getVetListSuccess(response: [VeterinaryResponse])
    func getVetListFailure(error: String)
}

final class ContractVetListInteractor: ContractVetListInteractorProtocol {
    var output: ContractVetListInteractorOutput?
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getContractVetList() {
        let request = GetVeterinariesRequest()
        networkManager.sendRequest(urlString: request.url, method: .get, headers: request.headers, responseType: [VeterinaryResponse].self) { [weak self] response in
            self?.output?.getVetListSuccess(response: response)
        } errorHandler: { [weak self] error in
            self?.output?.getVetListFailure(error: error.localizedDescription)
        }
    }
}
