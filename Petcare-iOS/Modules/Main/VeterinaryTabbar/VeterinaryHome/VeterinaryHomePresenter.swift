//
//  VeterinaryHomePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol VeterinaryHomePresenterProtocol {
    var numberOfVets: Int { get }
    func appointment(at index: Int) -> AppointmentModel?
    func navigateToDateList() -> Void
    func backToLogin() -> Void
    func didSelectAppointment(at index: Int)    
}

final class VeterinaryHomePresenter {
    private weak var view: VeterinaryHomeViewController?
    private let router: VeterinaryHomeRouterProtocol?
    private let interactor: VeterinaryHomeInteractorProtocol?
    
    let rezervationList: [AppointmentModel] = [
        AppointmentModel(rezervationName: "Fluffy's Checkup", date: "2024-05-15", time: "10:00", info: "Routine checkup for Fluffy"),
        AppointmentModel(rezervationName: "Max's Vaccination", date: "2024-05-17", time: "13:30", info: "Annual vaccination for Max"),
        AppointmentModel(rezervationName: "Buddy's Surgery", date: "2024-05-20", time: "15:00", info: "Minor surgery for Buddy"),
        // Ek veri örnekleri ekle
    ]
    
    init(view: VeterinaryHomeViewController?, router: VeterinaryHomeRouterProtocol?, interactor: VeterinaryHomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension VeterinaryHomePresenter: VeterinaryHomePresenterProtocol {
    var numberOfVets: Int {
        return rezervationList.count
    }
    
    func appointment(at index: Int) -> AppointmentModel? {
        guard index >= 0 && index < rezervationList.count else {
            // Index is out of range
            return nil
        }
        return rezervationList[index]
    }
    
    
    func didSelectAppointment(at index: Int) {
        
    }
    
    func navigateToDateList() {
        router?.navigateToDateList()
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
}

extension VeterinaryHomePresenter: VeterinaryHomeInteractorOutput {
    
}
