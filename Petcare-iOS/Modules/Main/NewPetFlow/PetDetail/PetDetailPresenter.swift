//
//  PetDetailPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import Foundation

protocol PetDetailPresenterProtocol {
    var petData: PetResponse { get set }
    func petTypeImage() -> String?
    func formattedAge() -> String
    func formattedHeight() -> String
    func formattedWeight() -> String
}

final class PetDetailPresenter: PetDetailPresenterProtocol {
    private weak var view: PetDetailViewProtocol?
    let router: PetDetailProtocol?
    let interactor: PetDetailInteractorProtocol?
    
    var petData: PetResponse
    
    init(view: PetDetailViewProtocol? = nil, router: PetDetailProtocol?, interactor: PetDetailInteractorProtocol?, petData: PetResponse) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.petData = petData
    }
    
    func petTypeImage() -> String? {
        switch petData.type {
        case "Dog":
            return "dog"
        case "Cat":
            return "cat"
        case "Bird":
            return "bird"
        case "Hamster":
            return "hamster"
        case "Rabbit":
            return "rabbit"
        case "Other":
            return "dog"
        default:
            return nil
        }
    }

    func formattedAge() -> String {
        return "\(petData.birthDate?.calculateAge() ?? "6 month")"
    }
    
    func formattedHeight() -> String {
        if let height = petData.height {
            return height >= 1.0 ? String(format: "%.2f m", height) : String(format: "%.2f cm", height * 100)
        }
        return "1.2 cm"
    }
    
    func formattedWeight() -> String {
        if let weight = petData.weight {
            return weight >= 1.0 ? String(format: "%.2f kg", weight) : String(format: "%.2f g", weight * 1000)
        }
        return "1.2 kg"
    }
}

extension PetDetailPresenter: PetDetailInteractorOutput {

}
