//
//  EmailValidationProvider.swift
//  project
//
//  Created by Dzmitry on 26.11.21.
//

import Foundation
import UIKit

protocol ValidationProtocol {
    var emailTextField: UITextField {get set}
    var passwordTextField: UITextField {get set}
    var confirmPasswordTextField: UITextField? {get set}
    
    
    func isValidMail() -> Bool
    func isValidPassword() -> Bool
    func isValidInput() -> (String, Bool)

}

class Validation {
    
    var emailTextField: UITextField
    var passwordTextField: UITextField
    var confirmPasswordTextField: UITextField?
    var errorLabel: UILabel
    
    init(emailTextField: UITextField, passwordTextField: UITextField, confirmPasswordTextField: UITextField?, errorLabel: UILabel) {
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.confirmPasswordTextField = confirmPasswordTextField
        self.errorLabel = errorLabel
    }
    
    func isValidMail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailTextField.text)
    }
    
    func isValidPassword() -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: passwordTextField.text)
    }
    
    
    
    func isFieldsFilled() -> Bool {
        if emailTextField.text != nil && passwordTextField.text != nil && (confirmPasswordTextField != nil ? confirmPasswordTextField!.text != nil : true){
            if (emailTextField.text!.isEmpty && passwordTextField.text!.isEmpty && (confirmPasswordTextField != nil ? confirmPasswordTextField!.text!.isEmpty : true)){
                  errorLabel.isHidden = false
                  errorLabel.text = "Fill the all fields"
                  return false
              } else if emailTextField.text!.isEmpty {
                  errorLabel.isHidden = false
                  errorLabel.text = "Fill the email field"
                  return false
              } else if passwordTextField.text!.isEmpty {
                  errorLabel.isHidden = false
                  errorLabel.text = "Fill the password field"
                  return false
              } else if (confirmPasswordTextField != nil ? (confirmPasswordTextField!.text != nil ? confirmPasswordTextField!.text!.isEmpty : false) : false) {
                  errorLabel.isHidden = false
                  errorLabel.text = "Fill the confirm password field"
                  return false
              }
              errorLabel.text = ""
              errorLabel.isHidden = true
              return true
        } else {
            errorLabel.text = "Fill the confirm password field"
            errorLabel.isHidden = false
            return false
        }
  
    }
    
    func isValidInput() -> Bool {
        if isFieldsFilled() {
            if !isValidMail() {
                errorLabel.text = "Incorrect email"
                errorLabel.isHidden = false
                return false
            }
            if !isValidPassword() {
                errorLabel.text = "Incorrect password"
                errorLabel.isHidden = false
                return false
            }
            if !isValidMail() && !isValidPassword() {
                errorLabel.text = "Incorrect email and password"
                errorLabel.isHidden = false
                return false
            }
            if confirmPasswordTextField != nil {
                if passwordTextField.text != confirmPasswordTextField!.text {
                    errorLabel.text = "Confirm password is't the same"
                    errorLabel.isHidden = false
                    return false
                }
            }
            errorLabel.text = ""
            errorLabel.isHidden = true
            return true
        }
        else {
            return false
        }
    }
    
    deinit {
        print("deinit")
    }
    
}


