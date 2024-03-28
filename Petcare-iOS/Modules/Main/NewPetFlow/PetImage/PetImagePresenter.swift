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
    
    init(view: PetImageViewProtocol?, router: PetImageRouterProtocol?, interactor: PetImageInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
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
        let result = setResultView() // Presenter'dan modeli al
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
