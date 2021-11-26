//
//  ViewController.swift
//  project
//
//  Created by Dzmitry on 17.11.21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {


    // MARK: Bad setup, in future do stackview
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        //MARK: textField.placeholder add constraint
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        //MARK: textField.placeholder add constraint
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.isSecureTextEntry = true
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
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(transitionToSignUpScreenButton)
        
        logInButton.addTarget(self, action: #selector(didTaplogInButton), for: .touchUpInside)
        transitionToSignUpScreenButton.addTarget(self, action: #selector(didTapTransitionToSignUpScreenButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createEmailTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createLogInButtonConstraint()
        createTransitionToSignUpScreenButtonConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //faceid
        //if (isAuthorized && (userDefaults.email.isEmpty && userDefaults.email) == false) == true { ... }
        
        emailTextField.becomeFirstResponder()
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
    
    @objc private func didTaplogInButton() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                strongSelf.showCreateAccount()
                let alert = UIAlertController(title: "Error", message: "Unable to login", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try once more", style: .default, handler: {_ in strongSelf.errorInput()} ))
                strongSelf.present(alert, animated: true)
                
                return
            }
            
            print("You have signed in")
        })
        
    }
    
    @objc private func didTapTransitionToSignUpScreenButton() {
        print("didTapTransitionToSignUpScreenButton")
    }
    
    func showCreateAccount() {
        
    }
    
    func errorInput() {
        emailTextField.text =  ""
        passwordTextField.text = ""
        
    }
    
    
}

