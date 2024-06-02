//
//  ReminderPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 17.03.2024.
//

import Foundation

protocol ReminderPresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
    func didSelectPet(at index: Int)
    var  data: [ReminderInfo] { get }
}

struct ReminderInfo {
    let petName: String
}

final class ReminderPresenter: ReminderPresenterProtocol {
    private weak var view: ReminderViewController?

    var title: String = "Reminder"
    let router: ReminderRouterProtocol?
    let interactor: ReminderInteractorProtocol?

    var data: [ReminderInfo] = [
        ReminderInfo(petName: "Dog"),
        ReminderInfo(petName: "Cat"),
        ReminderInfo(petName: "CAR"),
    ]
    
    init(view: ReminderViewController?,router: ReminderRouterProtocol?, interactor: ReminderInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor?.reminderTime()
    }
    
    func setTitle() -> String {
        return title
    }
    
    
    func didSelectPet(at index: Int) {
        let _ = data[index]
    }
    

}

extension ReminderPresenter: ReminderInteractorOutput { }
