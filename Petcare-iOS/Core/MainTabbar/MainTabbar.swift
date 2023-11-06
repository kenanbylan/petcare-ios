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
        loadCalendarTab()
        loadVetMapTab()
        loadSettingsTab()
    }
    
    private func tabbarInitView() {
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .white
    }
    
    func loadHomeTab() {
        let navigationController = UINavigationController()
        let homeView = HomeRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(homeView)
        navigationController.tabBarItem.image = UIImage(systemName: Tabbar.homeIcon)
        navigationController.tabBarItem.title = Tabbar.homeText
        self.addChild(navigationController)
    }
    
    func loadCalendarTab() {
        let navigationController = UINavigationController()
        let calendarView = CalendarRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(calendarView)
        navigationController.tabBarItem.image = UIImage(named: Tabbar.calendarIcon)
        navigationController.tabBarItem.title = Tabbar.calendarText
        self.addChild(navigationController)
    }
    
    
    func loadVetMapTab() {
        let navigationController = UINavigationController()
        let mapsView = VetMapRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(mapsView)
        navigationController.tabBarItem.image = UIImage(named: Tabbar.mapIcon)
        navigationController.tabBarItem.title = Tabbar.mapText
        self.addChild(navigationController)
    }
    
    func loadSettingsTab() {
        let navigationController = UINavigationController()
        let settings = SettingsRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(settings)
        navigationController.tabBarItem.image = UIImage(systemName: Tabbar.settingsIcon )
        navigationController.tabBarItem.title = Tabbar.settingsText
        self.addChild(navigationController)
    }
}
