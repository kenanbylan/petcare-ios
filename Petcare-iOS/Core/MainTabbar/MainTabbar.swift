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
        loadSettingsTab()
        loadVetMapTab()
    }
    
    private func tabbarInitView() {
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
    }
    
    func loadHomeTab() {
        let navigationController = UINavigationController()
        let homeView = HomeRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(homeView)
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.title = "Home"
        self.addChild(navigationController)
    }
    
    func loadCalendarTab() {
        let navigationController = UINavigationController()
        let calendarView = CalendarRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(calendarView)
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.title = "Calendar"
        self.addChild(navigationController)
    }
    
    
    func loadVetMapTab() {
        let navigationController = UINavigationController()
        let mapsView = VetMapRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(mapsView)
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.title = "Veterinary Map"
        self.addChild(navigationController)
    }
    
    func loadSettingsTab() {
        let navigationController = UINavigationController()
        let settings = SettingsRouter.build(navigationController: navigationController)
        navigationController.viewControllers.append(settings)
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.title = "Settings"
        self.addChild(navigationController)
    }
}
