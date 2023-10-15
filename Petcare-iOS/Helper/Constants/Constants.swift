//
//  Constants.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation

enum Constants {
    enum Storyboard {
        static let splash = "splash"
        static let authentication = "authentication"
        static let home = "home"
        static let onboarding = "Onboarding"
    }
    
    enum Controller {
        static let splash = "SplashViewController"
        static let onboarding = "OnboardingViewController"
        static let login = "LoginViewController"
        static let register = "RegisterViewController"
        static let forgotpassword = "ForgotPasswordViewController"
        static let smsOtp = "SmsOtpViewController"
        static let home = "HomeViewController"
        static let calender = "CalendarViewController"
        static let settings = "SettingsViewController"
        static let vetmaps = "VetMapsViewController"
    }
    
    enum Style {
        static let brandNameSize: CGFloat = 20
        static let addToCartRadius: CGFloat = 5
        static let promotionListBoldFont: CGFloat = 15
    }
    
    enum Image {
        static let barImageName = "homekit"
    }
    
    enum Text {
        static let homeTitle = "Mobile Case"
    }
}
