//
//  ManageNotificationPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol ManageNotificationPresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
}

final class ManageNotificationPresenter {
    private weak var viewController: ManageNotificationViewController?
    let router: ManageNotificationRouterProtocol?
    let interactor: ManageNotificationInteractorProtocol?
    
    //MARK: Variable's
    var title:String = "Manage Notification"
    
    init(viewController: ManageNotificationViewController? = nil, router: ManageNotificationRouterProtocol?, interactor: ManageNotificationInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension ManageNotificationPresenter: ManageNotificationPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func setTitle() -> String {
        return title
    }
}

extension ManageNotificationPresenter: ManageNotificationInteractorOutput {
    
}
