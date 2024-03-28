//
//  CalendarPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol CalendarPresenterProtocol {
    func viewDidLoad()
    func navigateToNearbyList(onlyShow: Bool) -> Void
    func navigateToReminder() -> Void
}

final class CalendarPresenter {
    private weak var view: CalendarViewController?
    let router: CalendarRouterProtocol?
    let interactor: CalendarInteractorProtocol?
    
    init(view: CalendarViewController?, router: CalendarRouterProtocol?, interactor: CalendarInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func navigateToNearbyList(onlyShow: Bool) {
        router?.navigateToNearbyList(with: onlyShow)
    }
    
    func viewDidLoad() {
        
    }
    
    func navigateToReminder() {
        router?.navigateToReminder()
    }
}

extension CalendarPresenter: CalendarInteractorOutput { }
