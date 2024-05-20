//
//  DateListInfoDetailInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//

import Foundation

protocol DateListInfoDetailInteractorProtocol {
    func fetchSettingsSections()
}

protocol DateListInfoDetailInteractorOutput {
    func settingsSectionsFetched(_ sections: [Section])
}

final class DateListInfoDetailInteractor: DateListInfoDetailInteractorProtocol {
    var output: DateListInfoDetailInteractorOutput?
    
    func fetchSettingsSections() {
    }
}
