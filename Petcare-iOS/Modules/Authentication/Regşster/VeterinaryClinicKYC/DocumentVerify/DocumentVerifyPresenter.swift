//
//  DocumentVerifyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
import Foundation

protocol DocumentVerifyPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func backToLogin() -> Void
}

final class DocumentVerifyPresenter {
    private weak var view: DocumentVerifyViewController?
    private let router: DocumentVerifyRouterProtocol?
    private let interactor: DocumentVerifyInteractorProtocol?
    
    init(view: DocumentVerifyViewController?, router: DocumentVerifyRouterProtocol?, interactor: DocumentVerifyInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension DocumentVerifyPresenter: DocumentVerifyPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func navigateMain() {
        
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
}


extension DocumentVerifyPresenter: DocumentVerifyInteractorOutput {
    
}
