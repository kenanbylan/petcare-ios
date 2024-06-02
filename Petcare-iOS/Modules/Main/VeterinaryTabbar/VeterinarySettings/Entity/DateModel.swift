//
//  DateModel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//

import UIKit

struct DayModel {
    let title: String
    let router: RouterDay
}

enum RouterDay {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}
