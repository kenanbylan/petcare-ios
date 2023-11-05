//
//  SplashPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.

import Foundation
import UIKit

protocol SplashPresenterProtocol: AnyObject {
    func viewDidLoad() -> Void
}

final class SplashPresenter: SplashPresenterProtocol {
        
    private weak var view: SplashViewProtocol?
    private let interactor: SplashInteractorProtocol
    private var router: SplashRouterProtocol?
    
    init(view: SplashViewProtocol? , interactor: SplashInteractorProtocol, router: SplashRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.checkInternetConnection()
        view?.prepareUI()
    }

}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func internetConnectionStatus(_ status: Bool) {
        if status {
            print("STATUS is true")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.router?.navigateToOnboarding()
            }
        } else {
            print("STATUS is nil ")
        }
    }
}
