//
//  DocumentVerifyInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol DocumentVerifyInteractorProtocol {
    func uploadPDF(_ pdf: String) -> Void
    func uploadImage(_ image: String) -> Void
}


protocol DocumentVerifyInteractorOutput {
    
}


final class DocumentVerifyInteractor: DocumentVerifyInteractorProtocol {
    var output: DocumentVerifyInteractorOutput?
    
    func uploadPDF(_ pdf: String) {
        
    }
    
    func uploadImage(_ image: String) {
        
    }
}
