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
    func getClinicName() -> String
    func getClinicAddress() -> String
    func getClinicPhone() -> String
}

final class VeterinaryDetailPresenter: VeterinaryDetailPresenterProtocol {
    private weak var view: VeterinaryDetailViewController?
    
    var title: String = "Nearby Detail Page"
    let router: VeterinaryDetailRouterProtocol?
    let interactor: VeterinaryDetailInteractorProtocol?
    
    var data: UserRegisterRequest?
    
    init(view: VeterinaryDetailViewController?,router: VeterinaryDetailRouterProtocol?, interactor: VeterinaryDetailInteractorProtocol?,data: UserRegisterRequest?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.data = data
    }
    
    func viewDidLoad() {
        interactor?.fetchVeterinaryData()
    }
    
    func setTitle() -> String {
        return title
    }
    
    func getClinicName() -> String {
        return data?.address?.clinicName ?? "Kucukyali"
    }
    
    func getClinicPhone() -> String {
        return data?.address?.phoneNumber ?? "053X XXX XX XX"
    }
    
    func getClinicAddress() -> String {
        let city = data?.address?.clinicCity ?? ""
        let district = data?.address?.clinicDistrict ?? ""
        return city + district
    }
    
}

extension VeterinaryDetailPresenter: VeterinaryDetailInteractorOutput { }
