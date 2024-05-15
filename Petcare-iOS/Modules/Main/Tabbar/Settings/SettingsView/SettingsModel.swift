//
//  SettingsModel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.01.2024.
//

import Foundation
import UIKit

struct SettingsModel {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let router: Router
}

enum Router {
    case donateRouter
    case apperance
    case manageNotification
    case privacyPolicy
    case personInformation
    case signOut
}
