//
//  HomeInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol HomeInteractorProtocol {
    func getVeterinaryData()
}

protocol HomeInteractorOutput {
    
}


final class HomeInteractor : HomeInteractorProtocol {
    var output: HomeInteractorOutput?
    
    func getVeterinaryData() {
        
    }
}

