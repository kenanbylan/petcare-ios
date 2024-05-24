//
//  VeterinarySettingsPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//
import Foundation

protocol VeterinarySettingsPresenterProtocol {
    func viewDidLoad() -> Void
    func backToLogin() -> Void
    func navigateDetail(detail: DayModel?)
    func getModels() -> [DayModel]?
}

final class VeterinarySettingsPresenter {
    private weak var view: VeterinarySettingsViewController?
    private let router: VeterinarySettingsRouterProtocol?
    private let interactor: VeterinarySettingsInteractorProtocol?
    private var models = [DayModel]()
    
    init(view: VeterinarySettingsViewController?, router: VeterinarySettingsRouterProtocol?, interactor: VeterinarySettingsInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func getModels() -> [DayModel]? {
        return models
    }
}

extension VeterinarySettingsPresenter: VeterinarySettingsPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchSettingsSections()
    }
    
    func navigateDetail(detail: DayModel?) {
        guard let detail = detail else { return }
        router?.navigateToDetail(detail: detail)
    }
    
    func backToLogin() {
        router?.backToLogin()
    }

}

extension VeterinarySettingsPresenter: VeterinarySettingsInteractorOutput {
    func settingsSectionsFetched(_ sections: [DayModel]) {
        // Interactor'dan gelen verileri saklama
        models = sections
        // View Controller'ı güncelleme
        view?.updateTableView()
    }
}
