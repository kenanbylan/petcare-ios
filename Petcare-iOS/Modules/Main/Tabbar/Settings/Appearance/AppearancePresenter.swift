//
//  ApperancePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import Foundation

protocol ApperancePresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
}

final class ApperancePresenter {
    private weak var viewController: AppearanceViewController?
    let router: AppearanceRouterProtocol?
    let interactor: AppearanceInteractorProtocol?
    
    //MARK: Variable's
    var title:String = "Appearance"
    
    init(viewController: AppearanceViewController? = nil, router: AppearanceRouterProtocol?, interactor: AppearanceInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension ApperancePresenter: ApperancePresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func setTitle() -> String {
        return title
    }
}

extension ApperancePresenter: AppearanceInteractorOutput {
    
}
