//
//  DocumentVerifyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.

import Foundation

protocol DocumentVerifyPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func navigateToResult() -> Void
}

final class DocumentVerifyPresenter {
    private weak var view: DocumentVerifyViewController?
    private let router: DocumentVerifyRouterProtocol?
    private let interactor: DocumentVerifyInteractorProtocol?
    private let data: UserRegisterRequest?
    
    init(view: DocumentVerifyViewController?, router: DocumentVerifyRouterProtocol?, interactor: DocumentVerifyInteractorProtocol?, data: UserRegisterRequest) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.data = data
    }
}

extension DocumentVerifyPresenter: DocumentVerifyPresenterProtocol {
    func viewDidLoad() { }
    
    func navigateMain() { }
    
    func navigateToResult() {
        print("DocumentVerifyData : \(data!)")
        router?.navigateToResult(data: data!)
    }
}

extension DocumentVerifyPresenter: DocumentVerifyInteractorOutput {
    
}
