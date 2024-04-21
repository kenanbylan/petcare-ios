//
//  PetTypePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.
//

import Foundation

protocol PetTypePresenterProtocol {
    func viewDidLoad()
    func navigateToPetInfo()

    var selectPet: String { get set }
    var petTypes: [String] { get }
    var title: String { get }
}

final class PetTypePresenter {
    private weak var view: PetTypeViewProtocol?
    let router: PetTypeRouterProtocol?
    let interactor: PetTypeInteractorProtocol?
    
    var selectedPet: String = ""
    private let petTypesList = ["Cat", "Dog", "Bird", "Fish", "Rabbit", "Other"]
    
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
        return "Hello my friend"
    }
    
    var petTypes: [String] {
        return petTypesList
    }
    
    func viewDidLoad() {
        
    }
    
    func navigateToPetInfo() {
        if !selectedPet.isEmpty {
            print("!!selectedPet : \(selectedPet)")
            router?.navigateToPetInfo(selectPet: selectedPet)
        }
    }
}

extension PetTypePresenter: PetTypeInteractorOutput {
    
}
