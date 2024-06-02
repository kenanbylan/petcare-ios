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
    func setTitle() -> String
    func didSelectAppointment(at index: Int)
}

final class VeterinaryHomePresenter {
    private weak var view: VeterinaryHomeViewController?
    private let router: VeterinaryHomeRouterProtocol?
    private let interactor: VeterinaryHomeInteractorProtocol?
    
    
    //MOCK DATA'S
    let rezervationList: [AppointmentModel] = [
        AppointmentModel(rezervationName: "Minnoş'un Kontrolü", date: "2024-05-15", time: "10:00", info: "Minnoş için rutin kontrol"),
        AppointmentModel(rezervationName: "Max'in Aşısı", date: "2024-05-17", time: "13:30", info: "Max için yıllık aşı"),
        AppointmentModel(rezervationName: "Pırpır'ın Ameliyatı", date: "2024-05-20", time: "15:00", info: "Boncuk için küçük bir ameliyat")
    ]

    init(view: VeterinaryHomeViewController?, router: VeterinaryHomeRouterProtocol?, interactor: VeterinaryHomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension VeterinaryHomePresenter: VeterinaryHomePresenterProtocol {
    
    func setTitle() -> String {
        return "VeterinaryHomeView_title".localized()
    }
    
    var numberOfVets: Int {
        return rezervationList.count
    }
    
    func appointment(at index: Int) -> AppointmentModel? {
        guard index >= 0 && index < rezervationList.count else { return nil }
        return rezervationList[index]
    }
    
    func didSelectAppointment(at index: Int) {
        //will be coded
    }
    
    func navigateToDateList() {
        router?.navigateToDateList()
    }
}

extension VeterinaryHomePresenter: VeterinaryHomeInteractorOutput {
    
}
