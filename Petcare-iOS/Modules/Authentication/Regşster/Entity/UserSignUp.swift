//
//  UserSignUp.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.11.2023.
//

import Foundation

struct UserSignUp {
    var firstName: String
    var lastname: String?
    var email: String
    var password: String
    var confirmPassword: String
    
    class Builder {
        var firstName: String?
        var lastname: String?
        var email: String?
        var password: String?
        var confirmPassword: String?
        
        func set(firstName: String) -> Builder {
            self.firstName = firstName
            return self
        }
        
        func set(lastname: String) -> Builder {
            self.lastname = lastname
            return self
        }
        
        func set(email: String) -> Builder {
            self.email = email
            return self
        }
        
        func set(password: String) -> Builder {
            self.password = password
            return self
        }
        
        func set(confirmPassword: String) -> Builder {
            self.confirmPassword = confirmPassword
            return self
        }
        
        func build() -> UserSignUp? {
            guard let firstName = firstName, !firstName.isEmpty else {return nil }
            guard let lastName = lastname, !lastName.isEmpty else { return nil }
            guard let email = email, !email.isEmpty else { return nil }
            guard let password = password, password.count >= 8 else { return nil }
            guard let confirmPassword = confirmPassword, confirmPassword == password else { return nil }
            return UserSignUp(firstName: firstName, lastname: lastname, email: email, password: password, confirmPassword: confirmPassword)
        }
    }
}

let user: UserSignUp? = UserSignUp.Builder()
    .set(firstName: "Kenan")
    .set(lastname: "Baylan")
    .set(email: "kenan.baylan4654@gmail.com")
    .set(password: "1234")
    .set(confirmPassword: "1234")
    .build()
