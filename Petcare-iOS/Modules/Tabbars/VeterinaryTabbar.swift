//
//  VeterinaryUITabBarController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

final class VeterinaryTabbar: UITabBarController {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarInitView()
        loadHomeTab()
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
        let homeView = VeterinaryHomeRouter.build(navigationController: navigationController,window: window)
        
        navigationController.viewControllers.append(homeView)
        navigationController.tabBarItem.image = UIImage(systemName: Tabbar.homeIcon)
        navigationController.tabBarItem.title = Tabbar.homeText
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
