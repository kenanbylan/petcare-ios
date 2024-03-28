//  SettingsInteractor.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 5.11.2023.

import UIKit

protocol SettingsInteractorProtocol {
    func fetchSettingsSections()
}

protocol SettingsInteractorOutput {
    func settingsSectionsFetched(_ sections: [Section])
}

final class SettingsInteractor: SettingsInteractorProtocol {
    var output: SettingsInteractorOutput?
    
    func fetchSettingsSections() {
        let generalOptions: [SettingsOptionType] = [
            .staticCell(model: SettingsModel(title: "Apperance", icon: UIImage(named: "apperance"), iconBackgroundColor: AppColors.bgColor2!, router: .apperance)),
            .staticCell(model: SettingsModel(title: "Personal Information", icon: UIImage(named: "person-info"), iconBackgroundColor: AppColors.bgColor2!, router: .personInformation )),
            .staticCell(model: SettingsModel(title: "Manage Notifications", icon: UIImage(named: "notify"), iconBackgroundColor: AppColors.bgColor2!,router: .manageNotification)),
            .staticCell(model: SettingsModel(title: "Privacy Policy", icon: UIImage(named: "privacy"), iconBackgroundColor: .bgColor2, router: .privacyPolicy))
        ]
        
        let donateOptions: [SettingsOptionType] = [
            .staticCell(model: SettingsModel(title: "Buy a coffee", icon: UIImage(named: "coffee"), iconBackgroundColor: .bgColor2, router: .donateRouter))
        ]
        
        let generalSection = Section(title: "General", options: generalOptions)
        let donateSection = Section(title: "Donate", options: donateOptions)
        
        output?.settingsSectionsFetched([generalSection, donateSection])
    }
}
