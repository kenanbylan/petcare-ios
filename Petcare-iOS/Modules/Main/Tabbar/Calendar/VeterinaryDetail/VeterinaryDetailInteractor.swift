//
//  VeterinaryDetailInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.03.2024.
//


import Foundation

protocol VeterinaryDetailInteractorProtocol {
    func fetchVeterinaryData()
}

protocol VeterinaryDetailInteractorOutput {
    
}

final class VeterinaryDetailInteractor: VeterinaryDetailInteractorProtocol {
    var output: VeterinaryDetailInteractorOutput?
    
    func fetchVeterinaryData() {
        
    }
}
