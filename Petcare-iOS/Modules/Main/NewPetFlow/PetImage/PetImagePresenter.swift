//
//  PetImagePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import Foundation

protocol PetImagePresenterProtocol {
    func navigateMainPage() -> Void
    func saveImage(data: String) -> Void
    func fetchRequest()
}

final class PetImagePresenter {
    private weak var view: PetImageViewProtocol?
    let router: PetImageRouterProtocol?
    let interactor: PetImageInteractorProtocol?
    let petInfoData: PetInfoModel
    var selectImage: String?
    
    init(view: PetImageViewProtocol?, router: PetImageRouterProtocol?, interactor: PetImageInteractorProtocol?, petInfoData: PetInfoModel) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.petInfoData = petInfoData
    }
}

extension PetImagePresenter: PetImagePresenterProtocol {
    func saveImage(data: String) {
        selectImage = data
    }
    
    func navigateMainPage() {
        router?.navigateToMainTabbar()
    }
    
    func fetchRequest() {
        let latestData = PetInfoModel(gender: petInfoData.gender,
                                      type: petInfoData.type,
                                      name: petInfoData.name,
                                      weight: petInfoData.weight,
                                      height: petInfoData.height,
                                      birthDate: petInfoData.birthDate,
                                      image: selectImage,
                                      specialInfo: petInfoData.specialInfo)
        
        interactor?.savePetRequest(petData: latestData)
    }
}

extension PetImagePresenter: PetImageInteractorOutput {
    func petsRegisterFailure(error: String) {
        view?.savePetsError(message: error)
    }
    
    func petsRegisterSuccess(response: PetResponse) {
        print("PET SAVE İMAGE  RESPONSE: \(response)")
        router?.navigateToMainTabbar()
    }
    
    func petsRegisterFailure(error: ExceptionErrorHandle) {
        print("PET SAVE İMAGE  RESPONSE: \(error)")
        view?.savePetsError(message: error.error ?? "petsRegisterFailure error")
    }
}
