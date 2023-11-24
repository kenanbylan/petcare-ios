//
//  Constants.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import Foundation

enum Constants {
    enum Storyboard {
        static let splash = "Splash"
        static let home = "Home"
        static let onboarding = "Onboarding"
        static let login = "Login"
        static let register = "Register"
        static let calendar = "Calendar"
        static let vetmap = "VetMap"
        static let settings = "Settings"
        static let forgotPassword = "ForgotPassword"
    }
    
    enum Controller {
        //Starting
        static let splash = "SplashViewController"
        static let onboarding = "OnboardingViewController"
        
        //Authentication
        static let login = "LoginViewController"
        static let register = "RegisterViewController"
        static let forgotpassword = "ForgotPasswordViewController"
        static let smsOtp = "SmsOtpViewController"
        
        //Tabbar
        static let home = "HomeViewController"
        static let calender = "CalendarViewController"
        static let settings = "SettingsViewController"
        static let vetmaps = "VetMapViewController"
    }
    
    enum CollectionViewCell {
        static let onboardingCell = "OnboardingCell"
    }
}



