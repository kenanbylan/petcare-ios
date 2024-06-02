//
//  ReminderInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 17.03.2024.
//

import Foundation

protocol ReminderInteractorProtocol {
    func reminderTime()
}

protocol ReminderInteractorOutput {
    
}

final class ReminderInteractor: ReminderInteractorProtocol {
    var output: ReminderInteractorOutput?
    
    func reminderTime() {
        
    }
}
