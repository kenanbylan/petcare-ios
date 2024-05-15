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


final class VeterinarySettingsInteractor:    VeterinarySettingsInteractorProtocol {
    
    var output: VeterinarySettingsInteractorOutput?
    
    func fetchSettingsSections() {
        let generalOptions: [DayListType] = [
            .staticCell(model: DateModel(title: "Monday", router: .monday)),
            .staticCell(model: DateModel(title: "Tuesday", router: .tuesday)),
            
                .staticCell(model: DateModel(title: "Wednesday", router: .wednesday)),
            
                .staticCell(model: DateModel(title: "Thursday", router: .thursday)),
            
                .staticCell(model: DateModel(title: "Friday", router: .friday))
        ]
        
        let generalSection = SectionDay(title: "Day List", options: generalOptions)
        
        output?.settingsSectionsFetched([generalSection])
    }
}
