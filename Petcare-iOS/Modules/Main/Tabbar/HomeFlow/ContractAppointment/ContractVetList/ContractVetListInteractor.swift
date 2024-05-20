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
    func getVetListSuccess()
    func getVetListFailure()
}

final class ContractVetListInteractor: ContractVetListInteractorProtocol {
    
    var output: ContractVetListInteractorOutput?
    
    func getContractVetList() {
        //backende istek atılacaktır.
    }
}
