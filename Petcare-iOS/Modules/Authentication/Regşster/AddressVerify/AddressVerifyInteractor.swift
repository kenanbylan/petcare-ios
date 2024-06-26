//
//  AddressVerifyInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol AddressVerifyInteractorProtocol {
    func getAddressInfo(_ address: String) -> Void
}

protocol AddressVerifyInteractorOutput {
    func successAddress(data: String) -> Void
    func failure(error: ExceptionErrorHandle) -> Void
}

final class AddressVerifyInteractor: AddressVerifyInteractorProtocol {
    var output: AddressVerifyInteractorOutput?
    
    func getAddressInfo(_ address: String) { }
    
}
