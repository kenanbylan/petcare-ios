//
//  String + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.11.2023.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localizedString, args)
    }
    
    func hasNumbers() -> Bool {
        return stringFulfillsRegex(regex: ".*[0-9].*")
    }
    
    func hasSpecialCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[^A-Za-z0-9].*")
    }
    
    func isValidEmail() -> Bool {
        return stringFulfillsRegex(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    private func stringFulfillsRegex(regex: String) -> Bool {
        let textTest = NSPredicate(format: "SELF MATCHES %@", regex)
        guard textTest.evaluate(with: self) else {
            return false
        }
        return true
    }
    
    func containsOnlyNumbers() -> Bool {
        return stringFulfillsRegex(regex: "^\\d*\\.?\\d+$")
    }
    
    func formatAsDistance() -> String {
        if let distanceValue = Double(self) {
            if distanceValue < 1000 {
                // If the distance is less than 1000 meters, format it as meters
                return "\(Int(distanceValue)) m"
            } else {
                // If the distance is 1000 meters or more, format it as kilometers
                let distanceInKm = distanceValue / 1000.0
                let roundedDistance = String(format: "%.1f", distanceInKm)
                return "\(roundedDistance) km"
            }
        } else {
            return self
        }
    }
    
    func calculateAge() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        let ageComponents = calendar.dateComponents([.year, .month], from: date, to: now)
        
        if let year = ageComponents.year, year == 0, let month = ageComponents.month {
            return "\(month) months old"
        } else if let year = ageComponents.year {
            return "\(year) yo"
        } else {
            return nil
        }
    }
}

