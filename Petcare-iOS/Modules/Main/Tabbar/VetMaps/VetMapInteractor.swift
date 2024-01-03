//
//  VetMapInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol VetMapInteractorProtocol {
    func getMapData()
}

protocol VetMapInteractorOutput {
    
}


final class VetMapInteractor : VetMapInteractorProtocol {

    var output: VetMapInteractorOutput?
    func getMapData() {
        
    }
    
}

