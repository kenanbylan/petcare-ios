//
//  PetInfoPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.

import Foundation

protocol PetInfoPresenterProtocol {
    func viewDidLoad()
    func navigateSelectPetImage()
    func selectedGenderType(index: Int) -> Gender?
    func savePetInfo(_ data: PetInfoModel)
    
    var title: String { get }
    var selectedPet: String { get set }
    var selectedDateTime: Date { get set }
    var petGenre: Int { get set }
}

final class PetInfoPresenter {
    private weak var view: PetInfoViewProtocol?
    let router: PetInfoRouterProtocol?
    let interactor: PetInfoInteractorProtocol?
    var selectedPet: String
    var selectedDateTime: Date = .now //MARK: Default value is empty
    var petGenre: Int = 0 //Default male
    var petInfoData: PetInfoModel?
    
    
    init(view: PetInfoViewProtocol?, router: PetInfoRouterProtocol?, interactor: PetInfoInteractorProtocol?, selectedPet: String) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.selectedPet = selectedPet
    }
}

extension PetInfoPresenter: PetInfoPresenterProtocol {
    
    func savePetInfo(_ data: PetInfoModel) {
        petInfoData = data
    }
    
    func selectedGenderType(index: Int) -> Gender? {
        return index == 0 ? .MALE : .FEMALE
    }
    
    var title: String {
        return "Almost Done"
    }
    
    func navigateSelectPetImage() {
        router?.navigateSelectPetImage(petInfoData!)
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
}

extension PetInfoPresenter: PetInfoInteractorOutput {
    
}

