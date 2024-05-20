//
//  AddressVerifyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol AddressVerifyPresenterProtocol {
    func navigateDocumentVerify() -> Void
    func saveVetAddressData(address: VetAddress) -> Void
}

final class AddressVerifyPresenter {
    private weak var view: AddressVerifyViewController?
    private let router: AddressVerifyRouterProtocol?
    private let interactor: AddressVerifyInteractorProtocol?
    private let userInfo: UserRegisterRequest?
    
    private var clinicAddress: VetAddress?
    
    init(view: AddressVerifyViewController?, router: AddressVerifyRouterProtocol?, interactor: AddressVerifyInteractorProtocol?,userInfo: UserRegisterRequest?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.userInfo = userInfo
    }
}

extension AddressVerifyPresenter: AddressVerifyPresenterProtocol {
    func saveVetAddressData(address: VetAddress) {
        self.clinicAddress = address
    }
    
    func navigateDocumentVerify() {
        guard let userInfo = userInfo else {
            return
        }
        
        let data = UserRegisterRequest(name: userInfo.name,
                                       surname: userInfo.surname,
                                       email: userInfo.email,
                                       password: userInfo.password,
                                       role: userInfo.role,
                                       address: clinicAddress)
        
        router?.navigateToDocumentVerify(data: data)
    }
}

extension AddressVerifyPresenter: AddressVerifyInteractorOutput {
    func successAddress(data: String) { }
    func failure(error: ExceptionErrorHandle) { }
}

