//
//  PetInfoPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import Foundation


protocol PetInfoPresenterProtocol {
    func viewDidLoad()
    func navigateSelectPetImage()

}

final class PetInfoPresenter {
    private weak var view: PetInfoViewProtocol?
    let router: PetInfoRouterProtocol?
    let interactor: PetInfoInteractorProtocol?
    
    init(view: PetInfoViewProtocol?, router: PetInfoRouterProtocol?, interactor: PetInfoInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}


extension PetInfoPresenter: PetInfoPresenterProtocol {
    func navigateSelectPetImage() {
        router?.navigateSelectPetImage()
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
}

extension PetInfoPresenter: PetInfoInteractorOutput {
    
}
