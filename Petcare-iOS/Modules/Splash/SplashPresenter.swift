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
        router?.navigateToOnboarding()
        //TODO:
        //        if TokenManager.shared.isTokenValid() {
        //            if TokenManager.shared.userRole == "VETERINARY" {
        //                router?.navigateToVeterinaryHome()
        //            } else if TokenManager.shared.userRole == "USER" {
        //                router?.navigateToHome()
        //            } else {
        //                router?.navigateToLogin()
        //            }
        //        } else {
        //            router?.navigateToLogin()
        //        }
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func internetConnectionStatus(_ status: Bool) {
        if status {
            print("Device Connected Internet")
        } else {
            print("Device not connected internet")
        }
    }
}
