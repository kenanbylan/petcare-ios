//
//  AddressVerifyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol AddressVerifyPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func navigateDocumentVerify() -> Void
    func backToLogin() -> Void
}

final class AddressVerifyPresenter {
    private weak var view: AddressVerifyViewController?
    private let router: AddressVerifyRouterProtocol?
    private let interactor: AddressVerifyInteractorProtocol?
    
    init(view: AddressVerifyViewController?, router: AddressVerifyRouterProtocol?, interactor: AddressVerifyInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AddressVerifyPresenter: AddressVerifyPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func navigateMain() {
        
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
    
    func navigateDocumentVerify() {
        router?.navigateToDocumentVerify()
    }
}


extension AddressVerifyPresenter: AddressVerifyInteractorOutput {
   
}
