//
//  PrivacyPolicyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol PrivacyPolicyPresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
}

final class PrivacyPolicyPresenter {
    private weak var viewController: PrivacyPolicyViewController?
    let router: PrivacyPolicyRouterProtocol?
    let interactor: PrivacyPolicyInteractorProtocol?
    
    //MARK: Variable's
    var title:String = "Privacy Policy"
    
    init(viewController: PrivacyPolicyViewController? = nil, router: PrivacyPolicyRouterProtocol?, interactor: PrivacyPolicyInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension PrivacyPolicyPresenter: PrivacyPolicyPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func setTitle() -> String {
        return title
    }
}

extension PrivacyPolicyPresenter: PrivacyPolicyInteractorOutput { }
