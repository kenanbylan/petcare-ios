//
//  ApperancePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import Foundation
import UIKit

protocol AppearancePresenterProtocol {
    var numberOfRows: Int { get }
    func modeTitle(for index: Int) -> String
    func didSelectRowAt(index: Int)
    func setTitle() -> String
}

final class AppearancePresenter {
    private weak var viewController: AppearanceViewController?
    let router: AppearanceRouterProtocol?
    let interactor: AppearanceInteractorProtocol?
    
    // MARK: Variable's
    var title: String = "AppearanceView_title".localized()
    
    init(viewController: AppearanceViewController? = nil, router: AppearanceRouterProtocol?, interactor: AppearanceInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension AppearancePresenter: AppearancePresenterProtocol {
    var numberOfRows: Int {
        return 3
    }
    
    func modeTitle(for index: Int) -> String {
        switch index {
        case 0: return "AppearanceView_dark".localized()
        case 1: return "AppearanceView_light".localized()
        case 2: return "AppearanceView_system".localized()
        default: return ""
        }
    }
    
    func didSelectRowAt(index: Int) {
        guard let viewController = viewController else { return }
        switch index {
        case 0:
            setAppearanceMode(.darkMode)
        case 1:
            setAppearanceMode(.lightMode)
        case 2:
            setAppearanceMode(.deviceMode)
        default:
            break
        }
        
        router?.backToLogin()
    }
    
    func setTitle() -> String {
        return title
    }
    
    private func setAppearanceMode(_ mode: AppearanceMode) {
        DispatchQueue.main.async {
            switch mode {
            case .darkMode:
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
                UserDefaults.standard.setValue("darkMode", forKey: "AppearanceMode")
            case .lightMode:
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
                UserDefaults.standard.setValue("lightMode", forKey: "AppearanceMode")
            case .deviceMode:
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .unspecified
                }
                UserDefaults.standard.setValue("deviceMode", forKey: "AppearanceMode")
            }
            UserDefaults.standard.synchronize()
        }
    }
}

extension AppearancePresenter: AppearanceInteractorOutput {
    ///MARK: Implement AppearanceInteractorOutput methods if needed
}

