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
    func settingsSectionsFetched(_ sections: [SectionDay])
}


final class VeterinarySettingsInteractor: VeterinarySettingsInteractorProtocol {
    var output: VeterinarySettingsInteractorOutput?
    
    func fetchSettingsSections() {
        let generalOptions: [DayListType] = [
            .staticCell(model: DateModel(title: "VeterinarySettingsView_monday".localized(), router: .monday)),
            .staticCell(model: DateModel(title: "VeterinarySettingsView_tuesday".localized(), router: .tuesday)),
            .staticCell(model: DateModel(title: "VeterinarySettingsView_wednesday".localized(), router: .wednesday)),
            .staticCell(model: DateModel(title: "VeterinarySettingsView_thursday".localized(), router: .thursday)),
            .staticCell(model: DateModel(title: "VeterinarySettingsView_friday".localized(), router: .friday))
        ]
        
        let generalSection = SectionDay(title: "VeterinarySettingsView_clinic".localized(), options: generalOptions)
        output?.settingsSectionsFetched([generalSection])
    }
}
