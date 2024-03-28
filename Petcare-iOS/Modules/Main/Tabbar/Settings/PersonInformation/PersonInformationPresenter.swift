//
//  PersonInformationPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol PersonInformationPresenterProtocol {
    func viewDidload()
    func viewWillAppear()
    func setTitle() -> String
}

final class PersonInformationPresenter {
    private weak var viewController: PersonInformationViewController?
    let router: PersonInformationRouterProtocol?
    let interactor: PersonInformationInteractorProtocol?

    //MARK: Variable's
    var title:String = "Personal Information"
    
    init(view: PersonInformationViewController? = nil, router: PersonInformationRouterProtocol?, interactor: PersonInformationInteractorProtocol?) {
        self.viewController = view
        self.router = router
        self.interactor = interactor
    }
}

extension PersonInformationPresenter: PersonInformationPresenterProtocol {
    func setTitle() -> String {
        return title
    }
    
    func viewDidload() { }
    func viewWillAppear() { }
}

extension PersonInformationPresenter: PersonInformationInteractorOutput {
    
}
