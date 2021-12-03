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
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.returnKeyType = UIReturnKeyType.go
        return textField
    }()
    
    private let errorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    private let logInButton : UIButton = {
        let button = AuthorizationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(didTaplogInButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    
    private let transitionToSignUpScreenButton : UIButton = {
        let button = AuthorizationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionToSignUpScreenButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(errorLabel)
        view.addSubview(logInButton)
        view.addSubview(transitionToSignUpScreenButton)
        
        configureTapGesture()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0
        }
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) { nc in
            self.checkForEnableLogInButton()
        }
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
        //else emailTextField.becomeFirstResponder()
        
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
    
    @objc private func didTaplogInButton() {
        print("logbtn")
        errorLabel.text = ""
        errorLabel.isHidden = true
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        
        let isValid = Validation(email: email, password: password, confirmPassword: nil)

        if isValid.isValidMail() {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    let alert = UIAlertController(title: "Error", message: "Unable to login", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try once more", style: .default, handler: {_ in
                        strongSelf.cleanInputSignInFields()
                        strongSelf.emailTextField.becomeFirstResponder()
                    } ))
                    strongSelf.present(alert, animated: true)
                    return
                }
                
                print("You have signed in")
            })
        } else {
            errorLabel.text = "Incorrect email."
            errorLabel.isHidden = false
            emailTextField.text =  ""
            passwordTextField.text = ""
            checkForEnableLogInButton()
            emailTextField.becomeFirstResponder()
        }
    }
    
    //MARK: here
    @objc private func didTapTransitionToSignUpScreenButton() {
        print("didTapTransitionToSignUpScreenButton")
        cleanInputSignInFields()
        view.endEditing(true)
        present(SignUpViewController(), animated: true, completion: nil)
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func cleanInputSignInFields() {
        emailTextField.text =  ""
        passwordTextField.text = ""
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    func checkForEnableLogInButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        if  !email.isEmpty && !password.isEmpty {
            logInButton.isUserInteractionEnabled = true
            logInButton.alpha = 1
            
        } else {
            logInButton.isUserInteractionEnabled = false
            logInButton.alpha = 0.5
        }
    }
}

extension SignInViewController: UITextFieldDelegate {

//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
//        checkForEnableLogInButton()
//    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            if logInButton.isUserInteractionEnabled == true {
                didTaplogInButton()
            }
        }
        return true
    }
}
