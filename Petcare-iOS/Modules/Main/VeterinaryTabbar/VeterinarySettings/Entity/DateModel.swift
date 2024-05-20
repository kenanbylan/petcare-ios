//
//  DateModel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//

import UIKit

struct DateModel {
    let icon: UIImage? = UIImage(systemName: "calendar")
    let title: String?
    let router: RouterDay
}

enum DayListType {
    case staticCell(model: DateModel)
}

enum RouterDay {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

struct SectionDay {
    let title: String
    let options: [DayListType]
}


