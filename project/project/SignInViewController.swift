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
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        //MARK: textField.placeholder add constraint
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        
        
        
        return textField
    }()
    
    
    
    
//    private let toggleSecureTextButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "eye.slash"), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
//        button.frame = CGRect(x: CGFloat(.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private let errorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    private let logInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(didTaplogInButton), for: .touchUpInside)
        return button
    }()
    
    private let transitionToSignUpScreenButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionToSignUpScreenButton), for: .touchUpInside)
        return button
    }()
    // MARK: ---------------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(errorLabel)
        view.addSubview(logInButton)
        view.addSubview(transitionToSignUpScreenButton)
        
        //logInButton.addTarget(self, action: #selector(didTaplogInButton), for: .touchUpInside)
//        transitionToSignUpScreenButton.addTarget(self, action: #selector(didTapTransitionToSignUpScreenButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createEmailTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createErrorLabelConstraint()
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
    
    func createErrorLabelConstraint() {
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 40),
            errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            errorLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createLogInButtonConstraint() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: 30),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            logInButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createTransitionToSignUpScreenButtonConstraint() {
        NSLayoutConstraint.activate([
            transitionToSignUpScreenButton.topAnchor.constraint(equalTo: logInButton.topAnchor, constant: 40),
            transitionToSignUpScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            transitionToSignUpScreenButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            transitionToSignUpScreenButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    // MARK: ---------------------------------------------------------------------------------------------------------
    
    @objc private func didTaplogInButton() {
        print("logbtn")
        errorLabel.text = ""
        errorLabel.isHidden = true
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {return}
              
        
        let isValid = Validation(email: email, password: password, confirmPassword: nil)
        
        if isValid.isFieldsFilled().0 {
            if isValid.isValidMail() {
                FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self] result, error in
                    guard let strongSelf = self else {
                        return
                    }
                    guard error == nil else {
                        let alert = UIAlertController(title: "Error", message: "Unable to login", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try once more", style: .default, handler: {_ in strongSelf.cleanInputSignInFields()} ))
                        strongSelf.present(alert, animated: true)
                        
                        return
                    }
                    
                    print("You have signed in")
                })
            } else {
                errorLabel.text = "Incorrect email."
                errorLabel.isHidden = false 
            }
        } else {
            errorLabel.text = isValid.isFieldsFilled().1
            errorLabel.isHidden = false
        }
        
        
        
    }
    
    @objc private func didTapTransitionToSignUpScreenButton() {
        print("didTapTransitionToSignUpScreenButton")
        cleanInputSignInFields()
        present(SignUpViewController(), animated: true, completion: nil)
        
    }
    
  
    
    func cleanInputSignInFields() {
        emailTextField.text =  ""
        passwordTextField.text = ""
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    
    
    
}

extension SignInViewController: UITextFieldDelegate {
    
}
