//
//  NearbyListInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import Foundation

protocol NearbyListInteractorProtocol {
    func getTableViewList()
}

protocol NearbyListInteractOutput { }

final class NearbyListInteractor: NearbyListInteractorProtocol {
    var output: NearbyListInteractOutput?
    
    func getTableViewList() {
        
    }
}
