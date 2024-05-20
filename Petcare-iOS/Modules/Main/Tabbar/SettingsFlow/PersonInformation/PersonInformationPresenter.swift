//
//  PersonInformationPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol PersonInformationPresenterProtocol {
    func viewDidload()
    func setTitle() -> String
    func navigateToRoot()
    var personInformation: PersonResponse? { get set }
}

final class PersonInformationPresenter {
    //MARK: Variable's
    var title:String = "PersonInformationView_title".localized()
    var personInformation: PersonResponse?
    
    weak var view: PersonInformationViewController?
    let router: PersonInformationRouterProtocol?
    let interactor: PersonInformationInteractorProtocol?

    init(view: PersonInformationViewController? = nil, router: PersonInformationRouterProtocol?, interactor: PersonInformationInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension PersonInformationPresenter: PersonInformationPresenterProtocol {
    func setTitle() -> String {
        return title
    }
    
    func viewDidload() {
        interactor?.getPersonInfoData()
    }
    
    func navigateToRoot() {
        router?.navigateToRoot()
    }
    
}

extension PersonInformationPresenter: PersonInformationInteractorOutput {
    func getPersonInfoSuccess(response: [PersonResponse]) {
        guard let userId = TokenManager.shared.userId else {
            print("User ID is not available")
            return
        }
        
        if let matchedPerson = response.first(where: { $0.id == userId }) {
            personInformation = matchedPerson
            view?.showAlertMessage(message: "User information loaded successfully")
        } else {
            view?.showAlertMessage(message: "User not found")
        }
    }
    
    func getPersonInfoFailure(error: String) {
        
    }
}
