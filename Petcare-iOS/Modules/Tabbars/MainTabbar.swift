//
//  MainTabbar.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation
import UIKit

final class MainTabbar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarInitView()
        loadHomeTab()
        loadVetMapTab()
        loadSettingsTab()
    }
    
    private func tabbarInitView() {
        tabBar.tintColor = AppColors.primaryColor
        tabBar.backgroundColor = AppColors.bgColor
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = true
    }
    
    func loadHomeTab() {
        let navigationController = UINavigationController()
        let homeView = HomeRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(homeView)
        navigationController.tabBarItem.image = UIImage(systemName: Tabbar.homeIcon)
        navigationController.tabBarItem.title = Tabbar.homeText
        self.addChild(navigationController)
    }
    
    func loadVetMapTab() {
        let navigationController = UINavigationController()
        let mapsView = VetMapRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(mapsView)
        navigationController.tabBarItem.image = UIImage(systemName: Tabbar.mapIcon)
        navigationController.tabBarItem.title = Tabbar.mapText
        self.addChild(navigationController)
    }
    
    func loadSettingsTab() {
        let navigationController = UINavigationController()
        let settings = SettingsRouter.build(navigationController: navigationController, window: UIWindow())
        navigationController.viewControllers.append(settings)
        navigationController.tabBarItem.image = UIImage(systemName: Tabbar.settingsIcon )
        navigationController.tabBarItem.title = Tabbar.settingsText
        self.addChild(navigationController)
    }
}
