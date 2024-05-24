//
//  VeterinarySettingsInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol VeterinarySettingsInteractorProtocol {
    func fetchSettingsSections()
    
}

protocol VeterinarySettingsInteractorOutput {
    func settingsSectionsFetched(_ sections: [DayModel])
}

final class VeterinarySettingsInteractor: VeterinarySettingsInteractorProtocol {
    var output: VeterinarySettingsInteractorOutput?
    
    func fetchSettingsSections() {
        let generalOptions: [DayModel] = [
            DayModel(title: "VeterinarySettingsView_monday".localized(), router: .monday),
            DayModel(title: "VeterinarySettingsView_tuesday".localized(), router: .tuesday),
            DayModel(title: "VeterinarySettingsView_wednesday".localized(), router: .wednesday),
            DayModel(title: "VeterinarySettingsView_thursday".localized(), router: .thursday),
            DayModel(title: "VeterinarySettingsView_friday".localized(), router: .friday),
        ]
        output?.settingsSectionsFetched(generalOptions)
    }
}
