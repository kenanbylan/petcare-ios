//
//  PetInfoPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import Foundation
import Combine


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
    
    @Published var petName = ""
    @Published var petNameState: NameState = .idle
    
    @Published var petHeight = ""
    @Published var petHeightState: NameState = .idle
    
    @Published var petWeight = ""
    @Published var petWeightState: NameState = .idle
    
    func startValidation() {
        petNameState = validateField(petName, minLength: 4, hasNumbers: false, hasSpecialChars: true)
        petHeightState = validateField(petHeight, minLength: 3, hasNumbers: true)
        petWeightState = validateField(petWeight, minLength: 3, hasNumbers: true)
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

extension PetInfoPresenter {
    private func validateField(_ field: String, minLength: Int, hasNumbers: Bool = false, hasSpecialChars: Bool = false) -> NameState {
        if field.isEmpty {
            return .error(.empty)
        } else if field.count < minLength {
            return .error(.toShort)
        } else if hasNumbers && field.hasNumbers() {
            return .error(.numbers)
        } else if hasSpecialChars && field.hasSpecialCharacters() {
            return .error(.specialChars)
        } else {
            return .success
        }
    }
}


extension PetInfoPresenter {
    var isEmpty: AnyPublisher<Bool, Never> {
        $petName
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isToShort: AnyPublisher<Bool, Never> {
        $petName
            .map { !($0.count >= 2) }
            .eraseToAnyPublisher()
    }
    
    var hasNumbers: AnyPublisher<Bool, Never> {
        $petName
            .map { $0.hasNumbers() }
            .eraseToAnyPublisher()
    }
    
    var hasSpecialChars: AnyPublisher<Bool, Never> {
        $petName
            .map { $0.hasSpecialCharacters() }
            .eraseToAnyPublisher()
    }
}
