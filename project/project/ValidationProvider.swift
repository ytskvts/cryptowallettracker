//
//  EmailValidationProvider.swift
//  project
//
//  Created by Dzmitry on 26.11.21.
//

import Foundation
import UIKit

protocol ValidationProtocol {
    var email: String {get set}
    var password: String {get set}
    
    
    func isValidMail() -> Bool
    func isValidPassword() -> Bool
    func isValidInput() -> (String, Bool)

}

class Validation: ValidationProtocol {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
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
    
    func isValidInput() -> (String, Bool) {
        if !isValidMail() {
            return ("Incorrect email", false)
        }
        if !isValidPassword() {
            return ("Incorrest password", false)
        }
        if !isValidMail() && !isValidPassword() {
            return ("Incorrect email and password", false)
        }
        return ("", true)
    }

    
}


