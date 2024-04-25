//
//  DateListInfoInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import Foundation

protocol DateListInfoInteractorProtocol {
    func vetDateListChanges(dateTime: [String: String]) -> Void
}


protocol DateListInfoInteractorOutput {
    
}


final class DateListInfoInteractor: DateListInfoInteractorProtocol {
    var output: DateListInfoInteractorOutput?
    
    
    func vetDateListChanges(dateTime: [String : String]) {
        
    }

}
