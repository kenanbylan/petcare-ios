//
//  ResultVerifyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//
import Foundation

protocol ResultVerifyPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func backToLogin() -> Void
}

final class ResultVerifyPresenter {
    private weak var view: ResultVerifyViewController?
    private let router: ResultVerifyRouterProtocol?
    private let interactor: ResultVerifyInteractorProtocol?
    
    init(view: ResultVerifyViewController?, router: ResultVerifyRouterProtocol?, interactor: ResultVerifyInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ResultVerifyPresenter: ResultVerifyPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func navigateMain() {
        
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
}


extension ResultVerifyPresenter: ResultVerifyInteractorOutput {
   
}
