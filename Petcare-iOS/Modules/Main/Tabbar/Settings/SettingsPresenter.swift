//
//  SettingsPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol SettingsPresenterProtocol {
    func viewDidLoad()
    func navigateDetail(detail: SettingsModel)
    func setTitle() -> String
}

final class SettingsPresenter {
    
    //MARK: Variables
    var title: String = "Settings"
    
    private weak var view: SettingsViewController?
    let router: SettingsRouterProtocol?
    let interactor: SettingsInteractorProtocol?
    
    init(view: SettingsViewController? , router: SettingsRouterProtocol?, interactor: SettingsInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setTitle() -> String {
        return self.title
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchSettingsSections()
    }
    
    func navigateDetail(detail: SettingsModel) {
        router?.navigateToDetail(detail: detail)
    }
    
}

extension SettingsPresenter: SettingsInteractorOutput {
    func settingsSectionsFetched(_ sections: [Section]) {
        view?.updateTableView(with: sections)
    }
}
