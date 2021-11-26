//
//  ViewController.swift
//  project
//
//  Created by Dzmitry on 17.11.21.
//

import UIKit

class SignInViewController: UIViewController {


    // MARK: Bad setup, in future do stackview
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        return textField
    }()
    
    private let logInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        return button
    }()
    
    private let transitionToSignUpScreenButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    // MARK: ---------------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailTextField)
        createEmailTextFieldConstraint()
        view.addSubview(passwordTextField)
        createPasswordTextFieldConstraint()
        view.addSubview(logInButton)
        createLogInButtonConstraint()
        view.addSubview(transitionToSignUpScreenButton)
        createTransitionToSignUpScreenButtonConstraint()
    }
    
    
    
// MARK: Bad setup for constraints, in future change for stackview
    func createEmailTextFieldConstraint() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createPasswordTextFieldConstraint() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 40),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createLogInButtonConstraint() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 50),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            logInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func createTransitionToSignUpScreenButtonConstraint() {
        NSLayoutConstraint.activate([
            transitionToSignUpScreenButton.topAnchor.constraint(equalTo: logInButton.topAnchor, constant: 40),
            transitionToSignUpScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            transitionToSignUpScreenButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            transitionToSignUpScreenButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    // MARK: ---------------------------------------------------------------------------------------------------------

}

