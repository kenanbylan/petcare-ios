//
//  PetTypePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.
//

import Foundation

protocol PetTypePresenterProtocol {
    var selectPet: String { get set }
    var petTypes: [String] { get }
    var title: String { get }
    
    func navigateToPetInfo()
}

final class PetTypePresenter {
    private weak var view: PetTypeViewProtocol?
    let router: PetTypeRouterProtocol?
    let interactor: PetTypeInteractorProtocol?
    
    var selectedPet: String = ""
    private let petTypesList = ["PetTypeView_dog".localized(),
                                "PetTypeView_cat".localized(),
                                "PetTypeView_bird".localized(),
                                "PetTypeView_hamster".localized(),
                                "PetTypeView_rabbit".localized(),
                                "PetTypeView_other".localized()]
    
    init(view: PetTypeViewProtocol? = nil, router: PetTypeRouterProtocol?, interactor: PetTypeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension PetTypePresenter: PetTypePresenterProtocol {
    var selectPet: String {
        get { return selectedPet }
        set { selectedPet = newValue }
    }
    
    var title: String {
        return "Hello my friend" // will be add localizable.
    }
    
    var petTypes: [String] {
        return petTypesList
    }
     
    func navigateToPetInfo() {
        if !selectedPet.isEmpty {
            print("!!selectedPet : \(selectedPet)")
            router?.navigateToPetInfo(selectPet: selectedPet)
        }
    }
}


extension PetTypePresenter: PetTypeInteractorOutput { }
