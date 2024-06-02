//
//  PersonInformationInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol PersonInformationInteractorProtocol {
    func getPersonInfoData()
    var output: PersonInformationInteractorOutput? { get set }
}

protocol PersonInformationInteractorOutput {
    func getPersonInfoSuccess(response: [PersonResponse])
    func getPersonInfoFailure(error: String)
}

final class PersonInformationInteractor: PersonInformationInteractorProtocol {
    var output: PersonInformationInteractorOutput?
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getPersonInfoData() {
        let request = PersonRequest()
        networkManager.sendRequest(urlString: request.url,
                                   method: .get,
                                   headers: request.headers,
                                   responseType: [PersonResponse].self) { [weak self] response
            in
            self?.output?.getPersonInfoSuccess(response: response)
        } errorHandler: { [weak self] error in
            self?.output?.getPersonInfoFailure(error: error.localizedDescription)
        }
    }
}
