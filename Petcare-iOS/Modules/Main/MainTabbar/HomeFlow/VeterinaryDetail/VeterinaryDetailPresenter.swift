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
    func petNames() -> [String]
    
    var pets: [PetResponse] { get set }
}

final class VeterinaryDetailPresenter: VeterinaryDetailPresenterProtocol {
    private weak var view: VeterinaryDetailViewController?
    
    var title: String = "Nearby Detail Page"
    let router: VeterinaryDetailRouterProtocol?
    let interactor: VeterinaryDetailInteractorProtocol?
    
    var data: VeterinaryResponse?
    var pets: [PetResponse] = []

    
    init(view: VeterinaryDetailViewController?,router: VeterinaryDetailRouterProtocol?, interactor: VeterinaryDetailInteractorProtocol?,data: VeterinaryResponse?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.data = data
    }
    
    func viewDidLoad() {
        interactor?.fetchVeterinaryData()
        interactor?.getUserPets()
    }
    
    func petNames() -> [String] {
        return pets.map { $0.name ?? "Sirius" }
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

extension VeterinaryDetailPresenter: VeterinaryDetailInteractorOutput {
    func getPetsSuccess(response: [PetResponse]) {
        pets = response
        view?.updateView()
    }
    
    func getPetsFailure(error: String) {
        
    }
}
