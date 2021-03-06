//
//  EmailValidationProvider.swift
//  project
//
//  Created by Dzmitry on 26.11.21.
//

import Foundation
import UIKit



struct Validation: ValidationProtocol {
    
    var email: String
    var password: String
    var confirmPassword: String?
    
    init(email: String, password: String, confirmPassword: String?) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    func isValidMail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword() -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password) 
    }
    
    func isValidInput() -> (Bool, String) {
        var errorStatus: (Bool, String) = (true, "")
        if !isValidMail() {
            errorStatus.0 = false
            errorStatus.1 += "Incorrect email. "
        }
        if !isValidPassword() {
            errorStatus.0 = false
            errorStatus.1 += "Incorrect password. "
        }
        if (confirmPassword != nil ? confirmPassword != password : false) {
            errorStatus.0 = false
            errorStatus.1 += "Confirm password is't the same."
        }
        return errorStatus
    }
}


