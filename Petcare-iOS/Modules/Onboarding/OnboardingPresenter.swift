//
//  OnboardingPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.


import Foundation

protocol OnboardingPresenterInterface {
    
    var swipeData: [OnboardingModel] { get}
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
    
    let swipeData = [
        OnboardingModel(image: "onboard1", headline: "Make sure always be perfect parent to your pets", subheadline: "Pin your favorite restaurants and create your own food guide"),
        OnboardingModel(image: "onboard2", headline: "SHOW YOU THE LOCATION", subheadline: "Search and locate your favourite restaurant on Maps"),
        OnboardingModel(image: "onboard3", headline: "DISCOVER GREAT RESTAURANTS", subheadline: "Find restaurants shared by your friends and other foodies")
    ]
}

extension OnboardingPresenter: OnboardingPresenterInterface {
    func load() {
        view?.prepareUI()
        view?.setTitle("TESTTT")
    }
    
    func setupView() { }
    func setTitle(title: String?) { }
    
}
