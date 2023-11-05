//
//  CalendarInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol CalendarInteractorProtocol {
    func getVeterinaryData()
}

protocol CalendarInteractorOutput {
    
}


final class CalendarInteractor : CalendarInteractorProtocol {
    var output: CalendarInteractorOutput?
    
    func getVeterinaryData() {
        
    }
    
}

