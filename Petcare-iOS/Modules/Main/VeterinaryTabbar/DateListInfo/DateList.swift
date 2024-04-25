//
//  DateList.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import Foundation
import UIKit

struct HeaderItem: Hashable {
    let title: String
    let symbols: [DateList]
}

struct DateList: Hashable {
    let time: String
    var isSelected: Bool // Bu özellik her bir hücrenin seçili olup olmadığını belirler
    init(time: String, isSelected: Bool) {
        self.time = time
        self.isSelected = isSelected
    }
}

enum ListItem: Hashable {
    case header(HeaderItem)
    case symbol(DateList)
}

let modelObjects = [
    HeaderItem(title: "Monday", symbols: [
        DateList(time: "09:00 AM", isSelected: false),
        DateList(time: "10:00 AM", isSelected: true),
        DateList(time: "11:00 AM", isSelected: false),
        DateList(time: "13:00 PM", isSelected: false),
        DateList(time: "15:00 PM", isSelected: false),
        DateList(time: "17:00 PM", isSelected: false),
    ]),
    
//    HeaderItem(title: "Tuesday", symbols: [
//        DateList(time: "09:00 AM", isSelected: false),
//        DateList(time: "10:00 AM", isSelected: false ),
//        DateList(time: "11:00 AM", isSelected: true),
//        DateList(time: "13:00 PM", isSelected: false),
//        DateList(time: "15:00 PM", isSelected: false),
//        DateList(time: "17:00 PM", isSelected: false),
//    ]),
//    
//    HeaderItem(title: "Wednesday", symbols: [
//        DateList(time: "09:00 AM", isSelected: false),
//        DateList(time: "10:00 AM", isSelected: false ),
//        DateList(time: "11:00 AM", isSelected: false),
//        DateList(time: "13:00 PM", isSelected: true),
//        DateList(time: "15:00 PM", isSelected: false),
//        DateList(time: "17:00 PM", isSelected: false),
//    ]),
//    
//    HeaderItem(title: "Thursday", symbols: [
//        DateList(time: "09:00 AM", isSelected: false),
//        DateList(time: "10:00 AM", isSelected: true ),
//        DateList(time: "11:00 AM", isSelected: false),
//        DateList(time: "13:00 PM", isSelected: false),
//        DateList(time: "15:00 PM", isSelected: false),
//        DateList(time: "17:00 PM", isSelected: false),
//    ]),
//    
//    HeaderItem(title: "Friday", symbols: [
//        DateList(time: "09:00 AM", isSelected: false),
//        DateList(time: "10:00 AM", isSelected: false ),
//        DateList(time: "11:00 AM", isSelected: false),
//        DateList(time: "13:00 PM", isSelected: false),
//        DateList(time: "15:00 PM", isSelected: false),
//        DateList(time: "17:00 PM", isSelected: true),
//    ]),
    
]
