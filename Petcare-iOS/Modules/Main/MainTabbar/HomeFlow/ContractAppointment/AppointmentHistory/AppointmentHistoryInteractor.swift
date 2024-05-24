//
//  AppointmentHistoryInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation


protocol AppointmentHistoryInteractorProtocol {
    func getAppointmentHistory() -> Void
}

protocol AppointmentHistoryInteractorOutput {
    func getAppointmentHistorySuccess()
    func getAppointmentHistoryFailure()
}

final class AppointmentHistoryInteractor: AppointmentHistoryInteractorProtocol {
    
    var output: AppointmentHistoryInteractorOutput?
    
    func getAppointmentHistory() {
        //backende istek atılacaktır.
    }
}
