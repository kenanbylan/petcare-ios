//
//  VeterinarySettingsPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//
import Foundation

protocol VeterinarySettingsPresenterProtocol {
    func viewDidLoad() -> Void
    func navigateMain() -> Void
    func backToLogin() -> Void
    func navigateDetail(detail: DateModel?)
}

final class VeterinarySettingsPresenter {
    private weak var view: VeterinarySettingsViewController?
    private let router: VeterinarySettingsRouterProtocol?
    private let interactor: VeterinarySettingsInteractorProtocol?
    
    init(view: VeterinarySettingsViewController?, router: VeterinarySettingsRouterProtocol?, interactor: VeterinarySettingsInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension VeterinarySettingsPresenter: VeterinarySettingsPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchSettingsSections()
    }
    
    func navigateDetail(detail: DateModel?) {
        router?.navigateToDetail(detail: detail)
    }
    
    func navigateMain() {
        
    }
    
    func backToLogin() {
        router?.backToLogin()
    }
}


extension VeterinarySettingsPresenter: VeterinarySettingsInteractorOutput {
    func settingsSectionsFetched(_ sections: [SectionDay]) {
        view?.updateTableView(with: sections)
    }
    
    
}
