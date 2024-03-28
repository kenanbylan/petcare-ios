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
    func viewDidLoad()
    func didSelectRowAt(index: Int)
    func setTitle() -> String
}

final class ApperancePresenter {
    private weak var viewController: AppearanceViewController?
    let router: AppearanceRouterProtocol?
    let interactor: AppearanceInteractorProtocol?
    

    //MARK: Variable's
    var title:String = "Appearance"
    
    init(viewController: AppearanceViewController? = nil, router: AppearanceRouterProtocol?, interactor: AppearanceInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension ApperancePresenter: AppearancePresenterProtocol {
    var numberOfRows: Int {
        return 3
    }
    
    func modeTitle(for index: Int) -> String {
        switch index {
        case 0: return "Dark Mode"
        case 1: return "Light Mode"
        case 2: return "Device Mode"
        default: return ""
        }
    }
    
    func didSelectRowAt(index: Int) {
        switch index {
        case 0: // Dark Mode
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            UserDefaults.standard.set(AppTheme.dark.rawValue, forKey: "selectedTheme")
        case 1: // Light Mode
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
            UserDefaults.standard.set(AppTheme.light.rawValue, forKey: "selectedTheme")

        case 2: // Device Mode
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .unspecified
                }
                UserDefaults.standard.set(AppTheme.device.rawValue, forKey: "selectedTheme")
            }
        default:
            
            break
        }   
    }
    
    func viewDidLoad() {
        
    }
    
    func setTitle() -> String {
        return title
    }
}

extension ApperancePresenter: AppearanceInteractorOutput {
    
}
