//
//  OnboardingViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func prepareUI()
    func showOnboarding()
    func setup(buttonTitle: String)
    func getPage() -> Int
    func displayScreen(at index: Int)
    func isPossibleNext(_ newState: Bool)
    func showPrevButton()
    func hidePrevButton()
}

protocol OnboardingControlling {
    func capturedAction(direction: OnboardingViewRoute)
    func getCellViewModel(at row: Int) -> OnboardingModel
}

final class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenterProtocol?
    var viewDelegate: OnboardingViewDelegate?
    
    init(uiView: UIView, presenter: OnboardingPresenter? = nil, viewDelegate: OnboardingViewDelegate? = nil) {
        self.presenter = presenter
        self.viewDelegate = viewDelegate
        super.init(nibName: nil, bundle: nil)
        self.view = uiView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showOnboardingIfNeeded()
    }
}


///MARK: data,  viewController -> view
extension OnboardingViewController: OnboardingControlling {
    func capturedAction(direction: OnboardingViewRoute) {
        presenter?.verifyCapturedAction(direction: direction)
    }
    
    func getCellViewModel(at row: Int) -> OnboardingModel {
        presenter?.getCellData(row: row) ?? OnboardingModel(image: "", title: "", subtitle: "")
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    func prepareUI() {
        view.backgroundColor = .systemGreen
    }
    
    func showOnboarding() {
        viewDelegate?.showOnboarding()
    }
    
    func setup(buttonTitle: String) {
        viewDelegate?.setup(buttonTitle: buttonTitle)
    }
    
    func getPage() -> Int {
        viewDelegate?.getPage() ?? 3
    }
    
    func displayScreen(at index: Int) {
        viewDelegate?.displayScreen(at: index)
    }
    
    func isPossibleNext(_ newState: Bool) {
        viewDelegate?.isPossibleNext(newState)
    }
    
    func showPrevButton() {
        viewDelegate?.showPrevButton()
    }
    
    func hidePrevButton() {
        viewDelegate?.hidePrevButton()
    }
}
