//
//  DateListInfoPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import Foundation

protocol DateListInfoPresenterProtocol {
    func viewDidLoad() -> Void
    func saveDate() -> Void
}

final class DateListInfoPresenter {
    private weak var view: DateListInfoViewController?
    private let router: DateListInfoRouterProtocol?
    private let interactor: DateListInfoInteractorProtocol?
    
    init(view: DateListInfoViewController?, router: DateListInfoRouterProtocol?, interactor: DateListInfoInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension DateListInfoPresenter: DateListInfoPresenterProtocol {
    func saveDate() { }
    
    func viewDidLoad() { }
}


extension DateListInfoPresenter: DateListInfoInteractorOutput {
    
}
