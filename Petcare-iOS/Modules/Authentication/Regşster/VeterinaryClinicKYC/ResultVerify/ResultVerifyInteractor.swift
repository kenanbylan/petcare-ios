//
//  ResultVerifyInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation


protocol ResultVerifyInteractorProtocol {
    func resultData(_ data: String) -> Void
}


protocol ResultVerifyInteractorOutput {
    
}


final class ResultVerifyInteractor: ResultVerifyInteractorProtocol {
    var output: ResultVerifyInteractorOutput?
    
    func resultData(_ data: String) {
            
    }
}
