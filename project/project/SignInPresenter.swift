//
//  SignInPresenter.swift
//  project
//
//  Created by Dzmitry on 27.12.21.
//

import Foundation

class SignInPresenter: SignInPresenterProtocol {
    
    weak var signInViewController: SignInViewProtocol?
    
    var validator: ValidationProtocol
    
    required init(signInViewController: SignInViewProtocol, validator: ValidationProtocol) {
        self.signInViewController = signInViewController
        self.validator = validator
    }
    
    func logIn(email: String, password: String) {
        
    }
    
    
}
