//
//  SignUpViewController.swift
//  project
//
//  Created by Dzmitry on 26.11.21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

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
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Confirm password"
        //MARK: textField.placeholder add constraint
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.isSecureTextEntry = true
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
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(errorLabel)
        view.addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)

        // Do any additional setup after loading the view.
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
        
        emailTextField.becomeFirstResponder()
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
        let isValid = Validation(emailTextField: emailTextField, passwordTextField: passwordTextField, confirmPasswordTextField: confirmPasswordTextField, errorLabel: errorLabel)
        
        if isValid.isFieldsFilled() && isValid.isValidInput(){
            FirebaseAuth.Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!,
                                                completion: { [weak self] result, error in
                guard let strongSelf = self else {return}
                guard error == nil else {
                    let alert = UIAlertController(title: "Error", message: "Unable to register", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try once more", style: .default, handler: {_ in strongSelf.cleanInputSignUpFields()} ))
                    strongSelf.present(alert, animated: true)
                    return
                }
                print("You have sign up in")
                // save email and password
                strongSelf.cleanInputSignUpFields()
            })
            
        }
    }
    
    func cleanInputSignUpFields() {
        emailTextField.text =  ""
        passwordTextField.text = ""
        errorLabel.text = ""
        errorLabel.isHidden = true
        if confirmPasswordTextField.text != nil {
            confirmPasswordTextField.text = ""
        }
    }

}
