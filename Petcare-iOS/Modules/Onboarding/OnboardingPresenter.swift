//
//  OnboardingPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.


import Foundation

protocol OnboardingPresenterProtocol {
    func viewDidLoad()
    func navigateToLogin()
    func getCellData(row: Int) -> OnboardingModel
    func verifyCapturedAction(direction: OnboardingViewRoute)
    func showOnboardingIfNeeded()
}

enum OnboardingPage {
    case first, second, thirdy
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
        view?.prepareUI()
    }
    
    func navigateToLogin() {
        router?.navigateToLogin()
    }
    
    func showOnboardingIfNeeded() {
        if interactor!.userAlreadyExists() {
//            router?.navigateToLogin()
        } else {
            view?.showOnboarding()
        }
    }
}

extension OnboardingPresenter {
    func getCellData(row: Int) -> OnboardingModel {
        switch row {
        case 0:
            return  OnboardingModel(image: "onboard1", title: "ONBOARDING_TITLE_LABEL".localized() , subtitle: "ONBOARDING_SUBTITLE_LABEL".localized())
        case 1:
            return OnboardingModel(image: "onboard2", title: "ONBOARDING_TITLE_LABEL_2".localized(), subtitle: "ONBOARDING_SUBTITLE_LABEL_2".localized())
        case 2:
            return OnboardingModel(image: "onboard3", title: "ONBOARDING_TITLE_LABEL_3".localized(), subtitle: "ONBOARDING_SUBTITLE_LABEL_3".localized())
        default:
            return OnboardingModel(image: "", title: "", subtitle: "")
        }
    }
    
    func verifyCapturedAction(direction: OnboardingViewRoute) {
        let page = getCurrentPage()
        
        switch page {
        case .first:
            view?.displayScreen(at: 1)
        case .second:
            view?.setup(buttonTitle: "ONBOARDING_BUTTON_NEXT".localized())
            switch direction {
            case .next:
                view?.displayScreen(at: 2)
                view?.setup(buttonTitle: "ONBOARDING_BUTTON_LOGIN".localized())
            case .prev:
                view?.displayScreen(at: 0)
                view?.setup(buttonTitle: "ONBOARDING_BUTTON_GET_STARTED".localized())
            case .stop:
                print("show alert")
            }
        case .thirdy:
            view?.setup(buttonTitle: "ONBOARDING_BUTTON_LOGIN".localized())
            switch direction {
            case .next:
                router?.navigateToLogin()
            case .prev:
                view?.displayScreen(at: 2)
                view?.setup(buttonTitle: "ONBOARDING_BUTTON_NEXT".localized())
            case .stop:
                print("show alert")
            }
        }
    }
    
    func getCurrentPage() -> OnboardingPage {
        
        if let page = view?.getPage() {
            if page == 0 {
                return .first
            }
            if page == 1 {
                return .second
            }
            if page == 2 {
                return .thirdy
            }
        }
        return OnboardingPage.first
    }
}

extension OnboardingPresenter: OnboardingInteractorOutputProtocol { }
