//
//  VeterinaryDetailPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.03.2024.
//

import Foundation

protocol VeterinaryDetailPresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
    func setResultView() -> ApproveResultModel
}

final class VeterinaryDetailPresenter: VeterinaryDetailPresenterProtocol {
    private weak var view: VeterinaryDetailViewController?
    
    var title: String = "Nearby Detail Page"
    let router: VeterinaryDetailRouterProtocol?
    let interactor: VeterinaryDetailInteractorProtocol?
    
    
    init(view: VeterinaryDetailViewController?,router: VeterinaryDetailRouterProtocol?, interactor: VeterinaryDetailInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor?.fetchVeterinaryData()
    }
    
    func setTitle() -> String {
        return title
    }
    
    func setResultView() -> ApproveResultModel {
        let model = ApproveResultModel(
            backgroundImageName: "approve-background",
            title: "Tebrikler",
            subTitle: "Randevu oluşturuldu. Rezervasyon ekranından randevuyu görebilirsin.",
            imageName: "splash_transparent",
            buttonTitle: "Devam Et")
        return model
    }
}

extension VeterinaryDetailPresenter: VeterinaryDetailInteractorOutput { }
