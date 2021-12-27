//
//  SignInPresenterProtocol.swift
//  project
//
//  Created by Dzmitry on 24.12.21.
//

protocol SignInPresenterProtocol {
    
    init(signInViewController: SignInViewProtocol, validator: ValidationProtocol)
    
    func logIn(email: String, password: String)
    
    
}
