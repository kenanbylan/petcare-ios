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
        var generalOptions: [SettingsOptionType] = [
            .staticCell(model: SettingsModel(title: "SettingsView_appearence".localized(), icon: UIImage(named: "apperance"), iconBackgroundColor: AppColors.bgColor2!, router: .apperance)),
            .staticCell(model: SettingsModel(title: "SettingsView_person_info".localized(), icon: UIImage(named: "person-info"), iconBackgroundColor: AppColors.bgColor2!, router: .personInformation)),
            .staticCell(model: SettingsModel(title: "SettingsView_notification".localized(), icon: UIImage(named: "notify"), iconBackgroundColor: AppColors.bgColor2!, router: .manageNotification)),
            .staticCell(model: SettingsModel(title: "SettingsView_privacy".localized(), icon: UIImage(named: "privacy"), iconBackgroundColor: AppColors.bgColor2!, router: .privacyPolicy))
        ]
        
        if TokenManager.shared.userRole == "VETERINARY" {
            generalOptions.insert(.staticCell(model: SettingsModel(title: "SettingsView_vets".localized(), icon: UIImage(named: "pati"), iconBackgroundColor: AppColors.bgColor2!, router: .veterinaryAvaiableDay)), at: 2)
        }
        
        let donateOptions: [SettingsOptionType] = [
            .staticCell(model: SettingsModel(title: "SettingsView_signout".localized(), icon: UIImage(named: "coffee"), iconBackgroundColor: AppColors.bgColor2!, router: .signOut))
        ]
        
        let generalSection = Section(title: "General", options: generalOptions)
        let donateSection = Section(title: "SettingsView_exit".localized(), options: donateOptions)
        
        output?.settingsSectionsFetched([generalSection, donateSection])
    }
    
}
