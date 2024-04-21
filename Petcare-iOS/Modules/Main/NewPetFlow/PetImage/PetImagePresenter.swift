//
//  PetImagePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import Foundation

protocol PetImagePresenterProtocol {
    func viewDidLoad() -> Void
    func dismissScreen() -> Void
    func navigateMainPage() -> Void
    func navigateResultPage()
    func setResultView() -> ApproveResultModel
}

final class PetImagePresenter {
    private weak var view: PetImageViewProtocol?
    let router: PetImageRouterProtocol?
    let interactor: PetImageInteractorProtocol?
    let petInfoData: PetInfoModel
    
    init(view: PetImageViewProtocol?, router: PetImageRouterProtocol?, interactor: PetImageInteractorProtocol?, petInfoData: PetInfoModel) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.petInfoData = petInfoData
    }

    
    func setResultView() -> ApproveResultModel {
        let model = ApproveResultModel(
            backgroundImageName: "approve-background",
            title: "Ekledinnnn!!",
            subTitle: "Evcil Hayvanını Ekledin. Anasayfadaki evcil hayvanlarının görebilir ve diğer yavrucukları ekleyebilirsin :)",
            imageName: "splash_transparent",
            buttonTitle: "Devam Et")
        return model
    }
}

extension PetImagePresenter: PetImagePresenterProtocol {
    func navigateResultPage() {
        let result = ApproveResultModel(backgroundImageName: "approve-background",
                                        title: petInfoData.name,
                                        subTitle:"Evcil Hayvanını Ekledin. Anasayfadaki evcil hayvanlarının görebilir ve diğer yavrucukları ekleyebilirsin :)",
                                        imageName: petInfoData.image ?? "",
                                        buttonTitle: "Devam et" )
        
        router?.navigateToResultPage(model: result)
    }
    
    func navigateMainPage() {
        router?.navigateToMainTabbar()
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
    func dismissScreen() { }
}

extension PetImagePresenter: PetImageInteractorOutput { }
