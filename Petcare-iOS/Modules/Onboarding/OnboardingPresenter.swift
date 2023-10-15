//
//  OnboardingPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation

protocol OnboardingPresenterInterface {
    func load()
    func setupView()
    func setTitle(title: String?)
}

final class OnboardingPresenter {
    private weak var view: OnboardingViewInterface?
    private var router: OnboardingRouterInterface?
    private var interactor: OnboardingInteractorInterface?
    private var data: [OnboardingModel]?
    
    init(view: OnboardingViewInterface?, router: OnboardingRouterInterface?, interactor: OnboardingInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension OnboardingPresenter: OnboardingPresenterInterface {
    func load() {
        view?.prepareUI()
        view?.setTitle("TESTTT")
    }
    
    func setupView() {
    }
    
    func setTitle(title: String?) {
        
    }
    
}
