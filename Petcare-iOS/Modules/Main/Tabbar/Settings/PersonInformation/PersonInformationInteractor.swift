//
//  PersonInformationInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol PersonInformationInteractorProtocol {
    func getPersonInfoData()
}

protocol PersonInformationInteractorOutput {
    
}

final class PersonInformationInteractor: PersonInformationInteractorProtocol {
    var output: PersonInformationInteractorOutput?
    
    func getPersonInfoData() {
        
    }
}

