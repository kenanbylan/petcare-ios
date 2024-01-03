//
//  SettingsPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol SettingsPresenterProtocol {
    func viewDidLoad()
}

final class SettingsPresenter {
    
    private weak var view: SettingsViewController?
    let router: SettingsRouterProtocol?
    let interactor: SettingsInteractorProtocol?
    
    init(view: SettingsViewController? , router: SettingsRouterProtocol?, interactor: SettingsInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoad() {
        
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
   
}
