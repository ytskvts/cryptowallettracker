//
//  SignUpViewController.swift
//  project
//
//  Created by Dzmitry on 26.11.21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

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
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Confirm password"
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
    
    private let signUpButton : UIButton = {
        let button = AuthorizationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        view.backgroundColor = .black
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(errorLabel)
        view.addSubview(signUpButton)
        
        configureTapGesture()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0
        }
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) { nc in
            self.checkForEnableSignUpButton()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createEmailTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createConfirmPasswordTextFieldConstraint()
        createErrorLabelConstraint()
        createSignUpButtonConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //faceid
        //if (isAuthorized && (userDefaults.email.isEmpty && userDefaults.email) == false) == true { ... }
        //else emailTextField.becomeFirstResponder()
        
    }
    
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
    
    func createConfirmPasswordTextFieldConstraint() {
            NSLayoutConstraint.activate([
                confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 40),
                confirmPasswordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
                confirmPasswordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
                confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    func createErrorLabelConstraint() {
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: 40),
            errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            errorLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createSignUpButtonConstraint() {
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: 30),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            signUpButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc private func didTapSignUpButton() {
        print("didTapSignUpButton")
        errorLabel.text = ""
        errorLabel.isHidden = true
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else {return}
        
        let isValid = Validation(email: email, password: password, confirmPassword: confirmPassword)

        if isValid.isValidInput().0 {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password,
                                                completion: { [weak self] result, error in
                guard let strongSelf = self else {return}
                guard error == nil else {
                    let alert = UIAlertController(title: "Error", message: "Unable to register", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try once more", style: .default, handler: {_ in
                        strongSelf.cleanInputSignUpFields()
                        strongSelf.emailTextField.becomeFirstResponder()
                    } ))
                    strongSelf.present(alert, animated: true)
                    return
                }
                print("You have sign up in")
                let vc = CoinsListViewController()
                vc.modalPresentationStyle = .fullScreen
                strongSelf.present(vc, animated: true, completion: nil)
                // save email and password
                //strongSelf.cleanInputSignUpFields()
            })
        } else {
            errorLabel.text = isValid.isValidInput().1
            errorLabel.isHidden = false
            emailTextField.text =  ""
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            checkForEnableSignUpButton()
            emailTextField.becomeFirstResponder()
        }
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func cleanInputSignUpFields() {
        emailTextField.text =  ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    func checkForEnableSignUpButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else {return}
        if  !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty {
            signUpButton.isUserInteractionEnabled = true
            signUpButton.alpha = 1
            
        } else {
            signUpButton.isUserInteractionEnabled = false
            signUpButton.alpha = 0.5
        }
    }

}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        if textField == confirmPasswordTextField {
            if signUpButton.isUserInteractionEnabled == true {
                didTapSignUpButton()
            }
        }
        return true
    }
}
