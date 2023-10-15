//
//  SplashPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.10.2023.

import Foundation

protocol SplashPresenterInterface {
    func load()
}

final class SplashPresenter {
    private unowned var view : SplashViewControllerInterface?
    let router: SplashRouterInterface?
    let interactor: SplashInteractorInterface?
    
    init(view: SplashViewControllerInterface? , router: SplashRouterInterface?, interactor: SplashInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SplashPresenter: SplashPresenterInterface {
    func load() {
        interactor?.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutput {
    func internetConnectionStatus(_ status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.router?.navigate(.onboardingScreen)
            }
            
        } else {
            view?.noInternetConnection()
        }
    }
}
