//
//  PetTypeInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.
//

import Foundation

protocol PetTypeInteractorProtocol { }
protocol PetTypeInteractorOutput { }

final class PetTypeInteractor: PetTypeInteractorProtocol {
    var output: PetTypeInteractorOutput?
    
}
