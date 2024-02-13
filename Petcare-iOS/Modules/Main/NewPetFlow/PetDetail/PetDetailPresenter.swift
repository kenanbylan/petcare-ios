//
//  PetDetailPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import Foundation

protocol PetDetailPresenterProtocol {
    func viewDidLoad()
}

final class PetDetailPresenter {
    private weak var view: PetDetailViewProtocol?
    let router: PetDetailProtocol?
    let interactor: PetDetailInteractorProtocol?
    
    init(view: PetDetailViewProtocol? = nil, router: PetDetailProtocol?, interactor: PetDetailInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}


extension PetDetailPresenter: PetDetailPresenterProtocol {
    func viewDidLoad() {
    }
}

extension PetDetailPresenter: PetDetailInteractorOutput {
    
}
