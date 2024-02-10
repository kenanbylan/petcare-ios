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
        //MARK: Starting Screen
        static let splash = "SplashViewController"
        static let onboarding = "OnboardingViewController"
        
        //MARK: Authentication
        static let login = "LoginViewController"
        static let register = "RegisterViewController"
        static let forgotpassword = "ForgotPasswordViewController"
        static let smsOtp = "SmsOtpViewController"
        static let newPassword = "NewPasswordViewController"
        
        //MARK: Tabbar
        static let home = "HomeViewController"
        static let calender = "CalendarViewController"
        static let settings = "SettingsViewController"
        static let vetmaps = "VetMapViewController"
        
        //MARK: NewPetFlow SubMenu Controller
        static let petType = "PetTypeViewController"
        static let petInfo = "PetInfoViewController"
        static let petImage = "PetImageViewController"
        static let petResult = "PetResultViewController"
        
        //MARK: SettingsView SubViewController
        static let personInformation = "PersonInformationViewController"
        static let donate = "PersonInformation"
        static let manageNotification = "ManageNotificationViewController"
        static let privacyPolicy = "PrivacyPolicyViewController"
        
    }

    enum CollectionViewCell {
        static let onboardingCell = "OnboardingCell"
        static let settingsTableViewCell = "SettingTableViewCell"
    }
}
