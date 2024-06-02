//
//  AppointmentHistoryPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation


protocol AppointmentHistoryPresenterProtocol {
    var numberOfAppointment: Int { get }
    func viewDidLoad()
    func appointmentHistoryList(at index: Int) -> PastAppointment?
    func setTitle() -> String
}

final class AppointmentHistoryPresenter {
    private weak var view: AppointmentHistoryViewController?
    let interactor: AppointmentHistoryInteractorProtocol?
    let router: AppointmentHistoryRouterProtocol?
    
    var title: String = "Appointment History"
    
    //var appointmentHistory: [PastAppointment] = []
    
    var appointmentHistory: [PastAppointment] = [
        PastAppointment(animalName: "Rex", clinicName: "Happy Paws Clinic", date: "2024-01-15"),
        PastAppointment(animalName: "Bella", clinicName: "VetCare Center", date: "2024-02-20"),
        PastAppointment(animalName: "Max", clinicName: "Pet Wellness Clinic", date: "2024-03-10"),
        PastAppointment(animalName: "Luna", clinicName: "Animal Health Clinic", date: "2024-04-05"),
        PastAppointment(animalName: "Charlie", clinicName: "Healthy Pets Clinic", date: "2024-05-12"),
        PastAppointment(animalName: "Lucy", clinicName: "Paws & Claws Clinic", date: "2024-06-01")
    ]
    
    init(view: AppointmentHistoryViewController?, interactor: AppointmentHistoryInteractorProtocol?, router: AppointmentHistoryRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func setTitle() -> String {
        return self.title
    }
}

extension AppointmentHistoryPresenter: AppointmentHistoryPresenterProtocol {
    var numberOfAppointment: Int {
        return appointmentHistory.count
    }
    
    func viewDidLoad() {
        
    }
    
    func appointmentHistoryList(at index: Int) -> PastAppointment? {
        guard index >= 0 && index < appointmentHistory.count else {
            return nil
        }
        return appointmentHistory[index]
    }
    
}

extension AppointmentHistoryPresenter: AppointmentHistoryInteractorOutput {
    func getAppointmentHistorySuccess() {
        
    }
    
    func getAppointmentHistoryFailure() {
        
    }
    
}
