//
//  OnboardingPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.


import Foundation

protocol OnboardingPresenterProtocol {
    func viewDidLoad()
    func navigateToLogin()
}


final class OnboardingPresenter: OnboardingPresenterProtocol {
    
    private weak var view: OnboardingViewProtocol?
    private var router: OnboardingRouterProtocol?
    private var interactor: OnboardingInteractorProtocol?

    init(view: OnboardingViewController?, router: OnboardingRouterProtocol?, interactor: OnboardingInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor?.getData()
        view?.prepareUI()
    }
    
    
    func navigateToLogin() {
        router?.navigateToLogin()
    }

    
}

extension OnboardingPresenter: OnboardingInteractorOutputProtocol {
    
}
