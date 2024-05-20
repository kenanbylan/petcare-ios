//
//  DocumentVerifyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.

import Foundation

protocol DocumentVerifyPresenterProtocol {
    func navigateMain() -> Void
    func navigateToResult() -> Void
    func saveDocument(data: String) -> Void
    func fetchRequest() -> Void
}

final class DocumentVerifyPresenter {
    private weak var view: DocumentVerifyViewController?
    private let router: DocumentVerifyRouterProtocol?
    private let interactor: DocumentVerifyInteractorProtocol?
    private let data: UserRegisterRequest?
    
    var selectDocument: String?
    
    init(view: DocumentVerifyViewController?, router: DocumentVerifyRouterProtocol?, interactor: DocumentVerifyInteractorProtocol?, data: UserRegisterRequest) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.data = data
    }
}

extension DocumentVerifyPresenter: DocumentVerifyPresenterProtocol {
    func navigateMain() { }
    
    func fetchRequest() {
        let latestData = UserRegisterRequest(name: data?.name,
                                             surname: data?.surname,
                                             email: data?.email,
                                             password: data?.password,
                                             role: data?.role,
                                             address: data?.address,
                                             document: Document(base64Document: selectDocument))

        interactor?.veterinaryRequest(vet: latestData)
    }
    
    func saveDocument(data: String) {
        selectDocument = data
    }
    
    func navigateToResult() {
        let latestData = UserRegisterRequest(name: data?.name,
                                             surname: data?.surname,
                                             email: data?.email,
                                             password: data?.password,
                                             role: data?.role,
                                             address: data?.address,
                                             document: Document(base64Document: selectDocument))
        
        print("DocumentVerifyData : \(latestData)")
        router?.navigateToResult(data: latestData)
        
    }
}

extension DocumentVerifyPresenter: DocumentVerifyInteractorOutput {
    func vetRegisterSuccess(response: VetResponse) {
        guard let message = response.message else { return }
        self.view?.showSuccessAlert(message: message)
    }
    
    func vetRegisterFailure(error: ExceptionErrorHandle) {
        self.view?.showFailureAlert(message: error.error ?? "test")
    }
}
